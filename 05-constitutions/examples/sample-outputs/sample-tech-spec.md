# Technical Specification
## Dark Mode Toggle Feature

**Solutions Architect:** Mike Rodriguez
**Created:** January 22, 2025
**Status:** Approved
**Related PRD:** [Dark Mode Toggle PRD](./sample-prd.md)

---

## 1. Technical Summary

### Overview
Implement a client-side theme system that allows users to toggle between light and dark color schemes. The solution uses CSS custom properties for theming, localStorage for client-side persistence, and database storage for cross-device synchronization.

### Architectural Approach
- **Theme Management:** CSS variables + data attribute on `<html>` element
- **State Management:** React Context API for theme state
- **Persistence:** Dual-layer (localStorage + database)
- **System Detection:** `matchMedia` API for `prefers-color-scheme`

### Technology Stack
```
Frontend: React 18, TypeScript 5
Styling: Tailwind CSS 3 + CSS variables
State: React Context + localStorage
Backend: Next.js API routes
Database: PostgreSQL via Prisma
```

---

## 2. System Architecture

### 2.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Browser                             │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐ │
│  │              React Application                       │ │
│  │                                                      │ │
│  │  ┌────────────────────────────────────────────┐   │ │
│  │  │        ThemeProvider (Context)            │   │ │
│  │  │  - Current theme state                    │   │ │
│  │  │  - Toggle function                        │   │ │
│  │  │  - System preference listener            │   │ │
│  │  └────────────────────────────────────────────┘   │ │
│  │           ↓                    ↓                  │ │
│  │  ┌───────────────┐    ┌──────────────────┐      │ │
│  │  │  Components   │    │  Theme Toggle    │      │ │
│  │  │  (consume     │    │  UI Component    │      │ │
│  │  │   theme)      │    │                  │      │ │
│  │  └───────────────┘    └──────────────────┘      │ │
│  └──────────────────────────────────────────────────┘   │
│           ↓                                              │
│  ┌──────────────────────────────────────────────────┐   │
│  │            localStorage                          │   │
│  │  { theme: 'dark' | 'light' | 'auto' }           │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                          ↓ (sync on auth)
┌─────────────────────────────────────────────────────────────┐
│                    Backend (Next.js API)                    │
│                                                             │
│  POST /api/user/preferences                                │
│  GET  /api/user/preferences                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                  PostgreSQL Database                        │
│                                                             │
│  user_preferences table                                    │
│  ─────────────────────────────                            │
│  user_id    | theme_preference | updated_at               │
│  ────────────────────────────────────────                 │
│  uuid       | enum             | timestamp                │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Data Flow

**Initial Load:**
```
1. App loads → ThemeProvider initializes
2. Check localStorage for saved preference
3. If found → Apply theme
4. If not found → Detect system preference
5. If logged in → Fetch from database
6. Apply theme + save to localStorage
```

**Theme Toggle:**
```
1. User clicks toggle
2. ThemeProvider updates state
3. Save to localStorage immediately
4. Apply CSS class to <html> element
5. If logged in → POST to /api/user/preferences
6. Show success toast
```

**Cross-Device Sync:**
```
1. User logs in on new device
2. GET /api/user/preferences
3. Merge with localStorage (database wins)
4. Apply theme
```

---

## 3. Database Design

### 3.1 Schema Changes

**New Table: user_preferences**
```sql
CREATE TABLE user_preferences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  theme_preference VARCHAR(10) NOT NULL CHECK (theme_preference IN ('light', 'dark', 'auto')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  UNIQUE(user_id)
);

CREATE INDEX idx_user_preferences_user_id ON user_preferences(user_id);
```

**Prisma Schema:**
```prisma
model UserPreferences {
  id              String   @id @default(uuid())
  userId          String   @unique @map("user_id")
  themePreference String   @map("theme_preference") @db.VarChar(10)
  createdAt       DateTime @default(now()) @map("created_at")
  updatedAt       DateTime @updatedAt @map("updated_at")

  user User @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@map("user_preferences")
}
```

### 3.2 Migration Strategy
1. Create table via Prisma migration
2. No data backfill needed (new feature)
3. Set default to 'auto' for new users

---

## 4. Frontend Implementation

### 4.1 Theme Context Provider

**File:** `src/contexts/ThemeContext.tsx`

```typescript
import React, { createContext, useContext, useEffect, useState } from 'react';

type Theme = 'light' | 'dark' | 'auto';
type ResolvedTheme = 'light' | 'dark';

interface ThemeContextValue {
  theme: Theme;
  resolvedTheme: ResolvedTheme;
  setTheme: (theme: Theme) => void;
}

const ThemeContext = createContext<ThemeContextValue | undefined>(undefined);

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setThemeState] = useState<Theme>('auto');
  const [resolvedTheme, setResolvedTheme] = useState<ResolvedTheme>('light');

  // Initialize theme on mount
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as Theme | null;
    if (savedTheme) {
      setThemeState(savedTheme);
    } else {
      // Detect system preference
      const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      setResolvedTheme(systemPrefersDark ? 'dark' : 'light');
    }
  }, []);

  // Listen for system theme changes
  useEffect(() => {
    if (theme !== 'auto') return;

    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    const handler = (e: MediaQueryListEvent) => {
      setResolvedTheme(e.matches ? 'dark' : 'light');
    };

    mediaQuery.addEventListener('change', handler);
    return () => mediaQuery.removeEventListener('change', handler);
  }, [theme]);

  // Apply theme to DOM
  useEffect(() => {
    const effectiveTheme = theme === 'auto'
      ? (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
      : theme;

    setResolvedTheme(effectiveTheme);
    document.documentElement.setAttribute('data-theme', effectiveTheme);
  }, [theme]);

  const setTheme = async (newTheme: Theme) => {
    setThemeState(newTheme);
    localStorage.setItem('theme', newTheme);

    // Sync to backend if logged in
    const user = await getCurrentUser(); // pseudo-code
    if (user) {
      await fetch('/api/user/preferences', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ themePreference: newTheme }),
      });
    }
  };

  return (
    <ThemeContext.Provider value={{ theme, resolvedTheme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within ThemeProvider');
  return context;
};
```

### 4.2 CSS Architecture

**File:** `src/styles/theme.css`

```css
:root {
  /* Light theme (default) */
  --color-bg-primary: #ffffff;
  --color-bg-secondary: #f5f5f5;
  --color-bg-surface: #ffffff;

  --color-text-primary: #1a1a1a;
  --color-text-secondary: #666666;
  --color-text-tertiary: #999999;

  --color-border: #e0e0e0;
  --color-border-hover: #cccccc;

  --color-accent: #2563eb;
  --color-accent-hover: #1d4ed8;

  --color-success: #10b981;
  --color-warning: #f59e0b;
  --color-error: #ef4444;

  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
}

[data-theme="dark"] {
  --color-bg-primary: #1a1a1a;
  --color-bg-secondary: #2d2d2d;
  --color-bg-surface: #2d2d2d;

  --color-text-primary: #f5f5f5;
  --color-text-secondary: #b3b3b3;
  --color-text-tertiary: #808080;

  --color-border: #404040;
  --color-border-hover: #525252;

  --color-accent: #4a9eff;
  --color-accent-hover: #3b82f6;

  --color-success: #22c55e;
  --color-warning: #fbbf24;
  --color-error: #f87171;

  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.3);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.4);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.5);
}

/* Smooth transition for theme changes */
* {
  transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
}
```

**Tailwind Config Extension:**
```typescript
// tailwind.config.ts
module.exports = {
  theme: {
    extend: {
      colors: {
        'bg-primary': 'var(--color-bg-primary)',
        'bg-secondary': 'var(--color-bg-secondary)',
        'text-primary': 'var(--color-text-primary)',
        // ... etc
      }
    }
  }
}
```

### 4.3 Toggle UI Component

**File:** `src/components/ThemeToggle.tsx`

```typescript
import { Moon, Sun, Monitor } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';

export function ThemeToggle() {
  const { theme, setTheme } = useTheme();

  return (
    <div className="flex items-center gap-1 rounded-lg bg-bg-secondary p-1">
      <button
        onClick={() => setTheme('light')}
        className={`p-2 rounded ${theme === 'light' ? 'bg-bg-primary' : ''}`}
        aria-label="Light theme"
      >
        <Sun className="w-4 h-4" />
      </button>

      <button
        onClick={() => setTheme('auto')}
        className={`p-2 rounded ${theme === 'auto' ? 'bg-bg-primary' : ''}`}
        aria-label="Auto theme"
      >
        <Monitor className="w-4 h-4" />
      </button>

      <button
        onClick={() => setTheme('dark')}
        className={`p-2 rounded ${theme === 'dark' ? 'bg-bg-primary' : ''}`}
        aria-label="Dark theme"
      >
        <Moon className="w-4 h-4" />
      </button>
    </div>
  );
}
```

---

## 5. Backend Implementation

### 5.1 API Endpoints

**File:** `src/app/api/user/preferences/route.ts`

```typescript
import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/db';
import { getCurrentUser } from '@/lib/auth';

export async function GET(req: NextRequest) {
  try {
    const user = await getCurrentUser();
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const preferences = await prisma.userPreferences.findUnique({
      where: { userId: user.id },
    });

    return NextResponse.json({
      themePreference: preferences?.themePreference || 'auto',
    });
  } catch (error) {
    console.error('Failed to fetch preferences:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

export async function POST(req: NextRequest) {
  try {
    const user = await getCurrentUser();
    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await req.json();
    const { themePreference } = body;

    // Validate input
    if (!['light', 'dark', 'auto'].includes(themePreference)) {
      return NextResponse.json(
        { error: 'Invalid theme preference' },
        { status: 400 }
      );
    }

    // Upsert preference
    await prisma.userPreferences.upsert({
      where: { userId: user.id },
      create: {
        userId: user.id,
        themePreference,
      },
      update: {
        themePreference,
        updatedAt: new Date(),
      },
    });

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Failed to update preferences:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

---

## 6. Component Migration Strategy

### 6.1 Priority Order
1. **Phase 1 (Critical):** Layout, navigation, forms, buttons
2. **Phase 2 (High):** Tables, cards, modals
3. **Phase 3 (Medium):** Charts, graphs, data visualizations
4. **Phase 4 (Low):** Marketing pages, emails

### 6.2 Migration Checklist Per Component
```
[ ] Replace hardcoded colors with CSS variables
[ ] Test in both light and dark themes
[ ] Verify WCAG AA contrast ratios
[ ] Check hover/focus states
[ ] Test loading and error states
[ ] Update Storybook examples
```

---

## 7. Testing Strategy

### 7.1 Unit Tests

**File:** `src/contexts/__tests__/ThemeContext.test.tsx`

```typescript
import { renderHook, act } from '@testing-library/react';
import { ThemeProvider, useTheme } from '../ThemeContext';

describe('ThemeContext', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('defaults to auto theme', () => {
    const { result } = renderHook(() => useTheme(), {
      wrapper: ThemeProvider,
    });

    expect(result.current.theme).toBe('auto');
  });

  it('persists theme to localStorage', () => {
    const { result } = renderHook(() => useTheme(), {
      wrapper: ThemeProvider,
    });

    act(() => {
      result.current.setTheme('dark');
    });

    expect(localStorage.getItem('theme')).toBe('dark');
  });

  it('detects system preference', () => {
    window.matchMedia = jest.fn().mockImplementation(query => ({
      matches: query === '(prefers-color-scheme: dark)',
      addEventListener: jest.fn(),
      removeEventListener: jest.fn(),
    }));

    const { result } = renderHook(() => useTheme(), {
      wrapper: ThemeProvider,
    });

    expect(result.current.resolvedTheme).toBe('dark');
  });
});
```

### 7.2 Integration Tests

**Test Scenarios:**
1. Toggle theme → Verify DOM attribute changes
2. Refresh page → Theme persists
3. Login on new device → Preference syncs from database
4. Change system preference → Auto theme responds
5. Logout → Theme persists in localStorage

### 7.3 Accessibility Tests

```bash
# Run Lighthouse audit
npm run lighthouse -- --only-categories=accessibility

# Run axe-core
npm run test:a11y
```

**Manual Testing:**
- [ ] Keyboard navigation (tab through toggle)
- [ ] Screen reader announces theme change
- [ ] Color contrast check all components
- [ ] Focus indicators visible in both themes

---

## 8. Performance Considerations

### 8.1 Optimization Techniques
- CSS variables = no JavaScript for styling
- Single class toggle on root element
- Lazy load theme toggle component
- Debounce database sync (wait 500ms after toggle)

### 8.2 Bundle Size Impact
```
theme.css: 2.3 KB (gzipped)
ThemeContext.tsx: 1.8 KB (gzipped)
ThemeToggle.tsx: 0.9 KB (gzipped)
─────────────────────────────────
Total: ~5 KB increase
```

### 8.3 Performance Metrics
| Metric | Target | Actual |
|--------|--------|--------|
| Theme toggle latency | < 200ms | 45ms ✓ |
| Initial page load impact | < 50ms | 12ms ✓ |
| CSS variable calculation | < 10ms | 3ms ✓ |

---

## 9. Rollout Strategy

### 9.1 Feature Flag
```typescript
// lib/features.ts
export const DARK_MODE_ENABLED = process.env.NEXT_PUBLIC_DARK_MODE_ENABLED === 'true';

// Wrap toggle component
{DARK_MODE_ENABLED && <ThemeToggle />}
```

### 9.2 Deployment Plan
1. **Day 1:** Deploy to staging, internal testing
2. **Day 3:** Enable for 10% of users (A/B test)
3. **Day 7:** Review metrics, enable for 50%
4. **Day 10:** Full rollout to 100%

### 9.3 Rollback Plan
```typescript
// Emergency rollback: Set env var
NEXT_PUBLIC_DARK_MODE_ENABLED=false

// Deploy new build → Feature disappears
```

---

## 10. Monitoring & Analytics

### 10.1 Metrics to Track
- Theme preference distribution (light/dark/auto)
- Toggle usage frequency
- Time to first toggle
- Theme switching patterns
- Performance impact (bundle size, load time)

### 10.2 Analytics Events
```typescript
// Track theme change
analytics.track('Theme Changed', {
  fromTheme: 'light',
  toTheme: 'dark',
  source: 'header-toggle', // or 'settings-page'
});

// Track initial preference
analytics.track('Theme Initialized', {
  theme: 'auto',
  systemPreference: 'dark',
  isLoggedIn: true,
});
```

---

## 11. Edge Cases & Error Handling

| Edge Case | Handling |
|-----------|----------|
| localStorage unavailable | Fall back to session-only theme |
| API call fails | Show toast, retry once, fall back to localStorage |
| User has browser extension forcing colors | Document known conflicts in help docs |
| System preference changes mid-session | Update theme if user is on 'auto' |
| Database out of sync | Database wins, overwrite localStorage |

---

## 12. Documentation Requirements

### 12.1 Developer Docs
- [ ] Architecture decision record (ADR)
- [ ] CSS variable naming conventions
- [ ] Component migration guide
- [ ] Troubleshooting guide

### 12.2 User Docs
- [ ] Help article: "How to enable dark mode"
- [ ] FAQ: "Why does my theme reset?"
- [ ] Release notes entry

---

## 13. Open Technical Questions

- **Q:** Should we preload both theme stylesheets?
  **A:** No, use CSS variables to avoid duplicate styles

- **Q:** How to handle chart colors?
  **A:** Use CSS variables for chart colors, update Recharts theme config

- **Q:** Flash of wrong theme on page load?
  **A:** Inject theme script in `<head>` before render (blocking)

---

## 14. Acceptance Criteria

### Technical
- [ ] All components render correctly in both themes
- [ ] No console errors related to theming
- [ ] Theme persists across page refreshes
- [ ] Theme syncs across devices for logged-in users
- [ ] Performance metrics within targets
- [ ] Accessibility audit passes

### Functional
- [ ] User can toggle from header menu
- [ ] User can change in settings page
- [ ] Auto mode respects system preference
- [ ] Preference saves to database for logged-in users
- [ ] Preference saves to localStorage for logged-out users

---

## 15. Dependencies

### Internal
- Design system color tokens (completed)
- Prisma schema update (pending)

### External
- None

---

## 16. Timeline

| Milestone | Duration | Owner |
|-----------|----------|-------|
| Database migration | 1 day | Backend |
| ThemeContext implementation | 2 days | Frontend |
| Component migration | 5 days | Frontend |
| Testing & QA | 3 days | QA |
| Documentation | 1 day | Tech Writer |

**Total:** ~12 working days (2.5 weeks)

---

**Approved by:**
- Solutions Architect: Mike Rodriguez ✓
- Engineering Lead: Alex Thompson ✓
- Product Owner: Sarah Chen ✓

**Document Version:** 1.0
**Last Updated:** January 22, 2025
