#!/usr/bin/env bash
# Claude Code statusline — reads JSON from stdin, outputs a single line.
# Format: <branch>[*] | ctx <pct>% | 5h <pct>% (<reset>) | 7d <pct>% (<reset>) | <model>
set -euo pipefail

data=$(cat)

eval "$(echo "$data" | python3 -c "
import sys, json, time, math

d = json.load(sys.stdin)

branch = d.get('git', {}).get('branch', '')
model = d.get('model', {}).get('display_name', '')
cwd = d.get('cwd', '') or d.get('workspace', {}).get('current_dir', '')

ctx = d.get('context_window', {}) or {}
ctx_pct = ctx.get('used_percentage')
ctx_pct_s = f'{int(round(ctx_pct))}' if isinstance(ctx_pct, (int, float)) else '?'

rl = d.get('rate_limits', {}) or {}
five = rl.get('five_hour') or {}
seven = rl.get('seven_day') or {}

used_5h = int(five.get('used_percentage', 0)) if five else '?'
used_7d = int(seven.get('used_percentage', 0)) if seven else '?'

def fmt_reset_short(epoch):
    if not epoch:
        return ''
    diff = epoch - time.time()
    if diff <= 0:
        return 'now'
    h = int(diff // 3600)
    m = int(math.ceil((diff % 3600) / 60))
    if h > 0:
        return f'{h}h{m:02d}m'
    return f'{m}m'

def fmt_reset_long(epoch):
    if not epoch:
        return ''
    diff = epoch - time.time()
    if diff <= 0:
        return 'now'
    dd = int(diff // 86400)
    h = int((diff % 86400) // 3600)
    if dd > 0:
        return f'{dd}d{h:02d}h'
    return f'{h}h'

reset_5h = fmt_reset_short(five.get('resets_at'))
reset_7d = fmt_reset_long(seven.get('resets_at'))

# 5h pro-rata target: % of the 5-hour window elapsed.
FIVE_S = 5 * 3600
resets_5h_at = five.get('resets_at')
if resets_5h_at:
    remaining_5h = max(0, resets_5h_at - time.time())
    target_5h = int(round(max(0, min(100, (FIVE_S - remaining_5h) / FIVE_S * 100))))
else:
    target_5h = ''

# 7d pro-rata target: % of the week elapsed since the window started.
WEEK_S = 7 * 86400
resets_7d_at = seven.get('resets_at')
if resets_7d_at:
    remaining = max(0, resets_7d_at - time.time())
    target_7d = int(round(max(0, min(100, (WEEK_S - remaining) / WEEK_S * 100))))
else:
    target_7d = ''

print(f'branch={repr(branch)}')
print(f'model={repr(model)}')
print(f'cwd={repr(cwd)}')
print(f'ctx_pct={repr(ctx_pct_s)}')
print(f'used_5h={repr(str(used_5h))}')
print(f'used_7d={repr(str(used_7d))}')
print(f'target_5h={repr(str(target_5h))}')
print(f'target_7d={repr(str(target_7d))}')
print(f'reset_5h={repr(reset_5h)}')
print(f'reset_7d={repr(reset_7d)}')
" 2>/dev/null)" 2>/dev/null

# Fallbacks if python fails
branch="${branch:-}"
model="${model:-}"
cwd="${cwd:-}"
ctx_pct="${ctx_pct:-?}"
used_5h="${used_5h:-?}"
used_7d="${used_7d:-?}"
target_5h="${target_5h:-}"
target_7d="${target_7d:-}"
reset_5h="${reset_5h:-}"
reset_7d="${reset_7d:-}"

# Branch fallback + dirty flag
dirty=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  if [ -z "$branch" ]; then
    branch="$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '')"
  fi
  if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null | head -1)" ]; then
    dirty="*"
  fi
fi

branch_part="${branch}${dirty}"

GREEN=$'\033[32m'
AMBER=$'\033[33m'
RED=$'\033[31m'
CLR=$'\033[0m'

# ctx thresholds depend on window size (display_name contains "1M" on 1M variant).
#   1M:   green <20, amber 20–49, red >=50
#   200k: green <50, amber 50–69, red >=70
color_ctx() {
  local pct="$1" seg="$2" model_name="$3"
  local amber_at red_at
  if [[ "$model_name" == *1M* ]] || [[ "$model_name" == *1m* ]]; then
    amber_at=20; red_at=50
  else
    amber_at=50; red_at=70
  fi
  if [[ "$pct" =~ ^[0-9]+$ ]]; then
    if   [ "$pct" -ge "$red_at" ];   then printf '%s%s%s' "$RED"   "$seg" "$CLR"
    elif [ "$pct" -ge "$amber_at" ]; then printf '%s%s%s' "$AMBER" "$seg" "$CLR"
    else                                  printf '%s%s%s' "$GREEN" "$seg" "$CLR"
    fi
  else
    printf '%s' "$seg"
  fi
}

# Pro-rata color: green <= max(target, 10)%, red >= 90% or > target+10%, amber otherwise.
color_rate() {
  local pct="$1" target="$2" seg="$3"
  if [[ "$pct" =~ ^[0-9]+$ ]] && [[ "$target" =~ ^[0-9]+$ ]]; then
    local floor=$(( target > 10 ? target : 10 ))
    if   [ "$pct" -ge 90 ] || [ "$pct" -gt $((target + 10)) ]; then
      printf '%s%s%s' "$RED" "$seg" "$CLR"
    elif [ "$pct" -le "$floor" ]; then
      printf '%s%s%s' "$GREEN" "$seg" "$CLR"
    else
      printf '%s%s%s' "$AMBER" "$seg" "$CLR"
    fi
  else
    printf '%s' "$seg"
  fi
}

ctx_part=$(color_ctx "$ctx_pct" "ctx ${ctx_pct}%" "$model")

five_seg="5h ${used_5h}%"
[ -n "$reset_5h" ] && five_seg="${five_seg} (${reset_5h})"
five_part=$(color_rate "$used_5h" "$target_5h" "$five_seg")

seven_seg="7d ${used_7d}%"
[ -n "$reset_7d" ] && seven_seg="${seven_seg} (${reset_7d})"
seven_part=$(color_rate "$used_7d" "$target_7d" "$seven_seg")

# MCP-off indicator: ccf alias sets CC_MCP_MODE=fast (env propagates from shell → claude → statusline).
# Only show when off — the absence of the indicator means normal session.
mcp_part=""
if [ "${CC_MCP_MODE:-}" = "fast" ]; then
  mcp_part=" | ${RED}🔌 MCP-OFF${CLR}"
fi

echo "${branch_part} | ${ctx_part} | ${five_part} | ${seven_part} | ${model}${mcp_part}"
