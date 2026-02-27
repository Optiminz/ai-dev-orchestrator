# Template Variables Guide

**Purpose:** This document defines all template variables used in AI-Dev-Orchestrator prompts and explains how they should be populated.

---

## How Template Variables Work

All prompts in this framework use **template variables** with this syntax:
- `[VARIABLE_NAME]` - Placeholders that should be replaced before use

**Who fills them:**
- **AI (auto-populated)** - When Project Onboarding Guide copies prompts to your project
- **Human (at use-time)** - When you actually use the prompt

---

## Standard Template Variables

### Auto-Populated by AI (from CONSTITUTION.md)

These are filled when the Project Onboarding Guide copies prompts to your project:

| Variable | Source | Example Value | Used In |
|----------|--------|---------------|---------|
| `[LANGUAGE/FRAMEWORK]` | CONSTITUTION.md → Technical Stack | "Python/FastAPI", "TypeScript/React", "Go/Gin" | 2.2, 2.3 |
| `[PRIMARY_LANGUAGE]` | CONSTITUTION.md → Technical Stack | "Python", "TypeScript", "Go" | Multiple |
| `[DATABASE]` | CONSTITUTION.md → Technical Stack | "PostgreSQL", "MongoDB", "MySQL" | 1.3 |
| `[PROJECT_TYPE]` | Setup interview | "Internal Tool", "Client App", "SaaS Product" | 1.1 |
| `[STYLE_GUIDE]` | CONSTITUTION.md → Coding Standards | "Airbnb", "PEP 8", "Google" | 3.4 |

**Example CONSTITUTION.md snippet:**
```markdown
## 2. Technical Stack (The "What")

**Frontend:**
- Framework: React 18
- Language: TypeScript (strict mode)

**Backend:**
- Framework: FastAPI
- Language: Python 3.11+

**Database:**
- Primary: PostgreSQL 15+
```

**Auto-populated result in prompt:**
```markdown
You are an expert **TypeScript/React** developer.
```

---

### Filled by Human at Use-Time

These are filled each time you use the prompt:

| Variable | When to Fill | Example Value | Used In |
|----------|--------------|---------------|---------|
| `[YOUR_FEATURE_DESCRIPTION]` | Starting new feature | "Password reset via email" | 1.1 |
| `[FEATURE_NAME]` | After PRD created | "password-reset" | Multiple |
| `[NUMBER]` | Per task | "5", "12" | 2.2 |
| `[TASK_DESCRIPTION]` | Per task | "Implement createResetToken method" | 2.2 |
| `[FILE_PATHS_TO_REVIEW]` | When reviewing | "src/services/password-reset.service.ts" | 3.x |
| `[TARGET_USERS]` | Starting PRD | "Internal employees (~200)" | 1.1 |
| `[WHAT_PROBLEM]` | Starting PRD | "Too many help desk tickets" | 1.1 |
| `[RELATED_FEATURES]` | Starting PRD | "Email/password login" | 1.1 |

---

## Variable Naming Conventions

### ALL_CAPS with Underscores
```markdown
[LANGUAGE/FRAMEWORK]  ← Standard format
[PROJECT_TYPE]        ← Standard format
[DATABASE]            ← Standard format
```

### Descriptive Action Verbs
```markdown
[PASTE_TASK_DESCRIPTION_HERE]  ← Clear action required
[ATTACH_RELEVANT_FILES]        ← Clear action required
[YOUR_FEATURE_DESCRIPTION]     ← Clear ownership
```

### Avoid Ambiguity
❌ Bad: `[NAME]` - Name of what?
✅ Good: `[FEATURE_NAME]` - Clear context

❌ Bad: `[TYPE]` - Type of what?
✅ Good: `[PROJECT_TYPE]` - Clear context

---

## How Project Onboarding Guide Populates Variables

When the Project Onboarding Guide copies prompts to your project, it follows this logic:

### Step 1: Read CONSTITUTION.md
```python
# Parse technical stack
frontend_framework = "React 18"
frontend_language = "TypeScript"
backend_framework = "FastAPI"
backend_language = "Python 3.11+"
database = "PostgreSQL 15+"
```

### Step 2: Determine Primary Stack
```python
# For implementation prompts, use backend by default
[LANGUAGE/FRAMEWORK] = f"{backend_language}/{backend_framework}"
# Result: "Python/FastAPI"

# If task is frontend-specific, use frontend
[LANGUAGE/FRAMEWORK] = f"{frontend_language}/{frontend_framework}"
# Result: "TypeScript/React"
```

### Step 3: Replace in Prompt Template
```markdown
# Before:
You are an expert **[LANGUAGE/FRAMEWORK]** developer.

# After:
You are an expert **Python/FastAPI** developer.
```

### Step 4: Save to Project
```
my-project/
└── docs/
    └── prompts/
        └── 2.2-iterative-implementation.md  ← Pre-populated
```

---

## Adding New Template Variables

When creating or modifying prompts:

### 1. Choose Variable Name
- Use `[ALL_CAPS_WITH_UNDERSCORES]`
- Be descriptive and unambiguous
- Include context (PROJECT_TYPE not TYPE)

### 2. Document in This File
Add to the appropriate table:
- Auto-populated → Add to "Auto-Populated by AI" table
- User-filled → Add to "Filled by Human at Use-Time" table

### 3. Add to Project Onboarding Guide Logic
If auto-populated, update guides/project-onboarding.md with:
- Where to source the value (CONSTITUTION.md section)
- How to parse it
- Example values

### 4. Update Prompt Files
Use the variable in prompt templates with:
- Clear placeholder syntax: `[VARIABLE_NAME]`
- Example in comment: `# e.g., "Python/FastAPI"`
- Reference in "Template Variables Reference" table

---

## Special Cases

### Multiple Possible Values

Some prompts work with multiple languages/frameworks:

```markdown
You are an expert **[LANGUAGE/FRAMEWORK]** developer.

# Could be populated as:
# "Python/FastAPI" (backend task)
# "TypeScript/React" (frontend task)
# "Go/Gin" (API service)
```

**Solution:** Project Onboarding Guide asks user or infers from task context.

### Optional Variables

Some variables are optional:

```markdown
**Target Users:** [TARGET_USERS]  ← Optional context

# If not provided by user, AI can populate as:
# "General users", "Internal team", "Customers"
```

**Convention:** Optional variables get sensible defaults.

### Dynamic Variables

Some variables change per use:

```markdown
Task #[NUMBER]: [PASTE_TASK_DESCRIPTION_HERE]

# Task #5: Implement createResetToken method
# Task #12: Add error handling to login endpoint
```

**Convention:** These are ALWAYS filled by human at use-time, never pre-populated.

---

## Validation Checklist

When using a prompt, ensure:

- [ ] All `[VARIABLES]` are replaced with actual values
- [ ] No placeholder syntax remains in your final prompt
- [ ] Values match CONSTITUTION.md (for auto-populated ones)
- [ ] Context-specific values are accurate (task numbers, feature names)

### Quick Test

Search your filled prompt for:
```bash
grep -E '\[.*\]' your-prompt.md
```

If matches found → Variables still need filling!

---

## Examples

### Example 1: PRD Generation (1.1)

**Template:**
```markdown
Here is the feature I want to build:

[YOUR_FEATURE_DESCRIPTION]

**Additional Context:**
- Target users: [TARGET_USERS]
- Project type: [PROJECT_TYPE]
```

**Auto-populated by AI:**
```markdown
Here is the feature I want to build:

[YOUR_FEATURE_DESCRIPTION]  ← Human fills this

**Additional Context:**
- Target users: [TARGET_USERS]  ← Human fills this
- Project type: Internal Tool  ← AI filled from setup interview
```

**Final (filled by human):**
```markdown
Here is the feature I want to build:

I want users to reset their password via email if they forget it.

**Additional Context:**
- Target users: Internal employees (~200 people)
- Project type: Internal Tool
```

### Example 2: Implementation (2.2)

**Template:**
```markdown
You are an expert **[LANGUAGE/FRAMEWORK]** developer.

**Task List:** We are working on **Task #[NUMBER]**
```

**Auto-populated by AI:**
```markdown
You are an expert **Python/FastAPI** developer.  ← AI filled from CONSTITUTION.md

**Task List:** We are working on **Task #[NUMBER]**  ← Human fills per task
```

**Final (filled by human):**
```markdown
You are an expert **Python/FastAPI** developer.

**Task List:** We are working on **Task #5**
```

### Example 3: QA Review (3.1)

**Template:**
```markdown
You are a Senior QA Engineer. Review the following **[LANGUAGE]** code:

[PASTE_YOUR_CODE_HERE]
```

**Auto-populated by AI:**
```markdown
You are a Senior QA Engineer. Review the following **Python** code:  ← AI filled

[PASTE_YOUR_CODE_HERE]  ← Human pastes code
```

**Final (filled by human):**
```markdown
You are a Senior QA Engineer. Review the following **Python** code:

def create_reset_token(email):
    # ... actual code ...
```

---

## FAQ

### Q: What if my project uses multiple languages?

**A:** The Project Onboarding Guide will ask you to specify:
- Primary backend language
- Primary frontend language

It will populate `[LANGUAGE/FRAMEWORK]` based on context:
- Backend tasks → Backend language
- Frontend tasks → Frontend language
- You can manually override per prompt

### Q: Can I use my own variable naming?

**A:** Yes, but stick to conventions:
- Use `[ALL_CAPS_WITH_UNDERSCORES]`
- Document in this file
- Update Project Onboarding Guide if auto-populated

### Q: What if I forget to fill a variable?

**A:** The AI will likely complain or produce poor results. Always validate before submitting:
```bash
grep -E '\[.*\]' your-prompt.md
```

### Q: Can variables be nested?

**A:** Avoid nesting. Keep it simple:
❌ `[PROJECT_[TYPE]]` - Too complex
✅ `[PROJECT_TYPE]` - Simple and clear

---

## Related Resources

- [guides/project-onboarding.md](./guides/project-onboarding.md) - How AI populates variables
- [CONSTITUTION-TEMPLATE.md](./CONSTITUTION-TEMPLATE.md) - Source of truth for auto-populated variables
- [All Prompts](./prompts/) - See variables in context

---

**Last Updated:** 2025-11-19
**Version:** 1.0
