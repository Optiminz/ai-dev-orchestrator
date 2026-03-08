# Constitution: Team Expense Tracker

**Type:** Internal Tool
**Created:** 2025-01-15
**Last Updated:** 2025-01-15

---

## Project Overview

**Name:** Team Expense Tracker

**Purpose:** A simple expense tracking tool for our 10-person sales team to submit expense reports, attach receipts, and get manager approval. Replaces our current email + spreadsheet system which creates chaos at month-end and makes it impossible to track what's been approved vs. pending.

---

## Core Principles

**Remember:** This is an internal tool. These principles keep us focused:

1. **It just needs to work** - Function over aesthetics
2. **Keep it simple** - No over-engineering or unnecessary features
3. **Fast iteration** - Ship quickly, improve based on real feedback
4. **Solve the specific problem** - Don't build a universal solution

---

## Technical Stack

### Framework
```
Framework: Next.js 14 with App Router
Runtime: Node.js 18
Why: Team already uses React, Next.js gives us full-stack in one place
```

### Database
```
Database: Supabase (PostgreSQL)
Connection: Use Supabase client with environment variable
Migrations: Manual SQL files in db/migrations/
Why: Free tier works for our team size, handles file storage for receipts
```

### Frontend/Styling
```
Styling: Tailwind CSS 3
UI: Functional > beautiful (forms, tables, basic layouts)
Components: Shadcn/ui for form inputs, tables, buttons
Why: Fast to build, looks professional enough for internal use
```

### Authentication
```
Authentication: Supabase Auth (email/password only)
Users: Manually added by admin (no self-signup)
Sessions: 7-day expiration
Roles: Two roles only - "employee" and "manager"
```

### File Storage
```
Storage: Supabase Storage
Upload: Receipt images (PNG, JPG, PDF only)
Max file size: 5MB per receipt
Retention: Keep for 7 years (accounting requirement)
```

---

## User Context

**Who uses this:**
- 8 sales team members (submit expenses)
- 2 sales managers (approve/reject expenses)
- All users are internal employees
- All users have MacBooks and iPhones

**How they'll use it:**
- Web app only (desktop browsers)
- Mobile-responsive for viewing, but submission is desktop
- Used weekly during expense submission window
- Peak usage: Last week of each month

**Technical level:**
- Non-technical users
- Comfortable with Gmail and Google Sheets
- Need clear instructions and error messages

---

## Security Requirements

### Authentication & Authorization
- Email/password login required
- Role-based access:
  - Employees can only see/edit their own expenses
  - Managers can see all team expenses
- No public access

### Data Protection
- No PII in logs
- Receipt images in private storage bucket
- Expense amounts visible only to submitter and managers

### Input Validation
- All form inputs must be validated
- File uploads: Type and size checks
- SQL injection prevention (use Supabase client, not raw SQL)

---

## Coding Standards

### File Structure
```
app/
  (auth)/
    login/
    logout/
  dashboard/
  expenses/
    new/
    [id]/
  admin/
components/
  ui/
  expense-form.tsx
  expense-table.tsx
lib/
  supabase.ts
  utils.ts
```

### Naming Conventions
- Files: kebab-case (expense-form.tsx)
- Components: PascalCase (ExpenseForm)
- Functions: camelCase (getExpenses)
- Database tables: snake_case (expense_reports)

### Code Style
- TypeScript strict mode ON
- Prettier for formatting
- ESLint with Next.js config
- No unused variables or imports

### Comments
- Add comments for non-obvious logic only
- No commented-out code in commits
- Document all database queries with purpose

---

## Features & Scope

### What We're Building (In Scope)

**MVP Features:**
1. User login (email/password)
2. Submit expense with:
   - Date
   - Category (meals, travel, supplies, other)
   - Amount
   - Description
   - Receipt upload (1 image per expense)
3. View own expenses (list + detail)
4. Manager approval workflow (approve/reject with note)
5. Basic reporting (total pending, total approved by month)

### What We're NOT Building (Out of Scope)

- ❌ Integrations with accounting software (do manual export for now)
- ❌ Mobile app (web only)
- ❌ Expense splitting (one receipt = one expense)
- ❌ Multi-currency support (USD only)
- ❌ Automated receipt scanning/OCR (manual entry is fine)
- ❌ Budget tracking (just expense submission/approval)
- ❌ Email notifications (Slack pings are enough for now)

---

## Testing Approach

**For this internal tool:**
- Manual testing is fine
- No automated test suite required
- Test checklist:
  - [ ] Employee can submit expense
  - [ ] Manager can approve/reject
  - [ ] Receipt uploads work
  - [ ] Roles work correctly (employee can't see others' expenses)
  - [ ] Data persists across sessions

---

## Deployment

**Platform:** Vercel
**Environment:**
- Production: vercel.app URL
- No staging environment (YOLO deploy to production)

**Environment Variables:**
```
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

---

## Performance Requirements

**We don't need:**
- Sub-second load times
- Infinite scroll
- Real-time updates

**We DO need:**
- Works on desktop Chrome/Safari
- Receipt uploads < 10 seconds
- Forms don't lose data on error

---

## Error Handling

**User-facing errors:**
- Clear, friendly language
- Example: "Receipt upload failed. Please try again or use a smaller image."
- NOT: "Error 500: Internal Server Error"

**Developer errors:**
- Log to console is fine
- No error tracking service needed yet

---

## Documentation

**What we need:**
- README with setup instructions
- Comments in code for non-obvious things
- Basic user guide (1 page PDF with screenshots)

**What we DON'T need:**
- API documentation (no public API)
- Architecture diagrams
- Detailed developer docs

---

## AI Instructions

When generating code for this project:

1. **Keep it simple** - Use the most straightforward approach
2. **No premature optimization** - Don't add caching, memoization, etc. unless needed
3. **Use Supabase patterns** - Follow Supabase docs for auth, database, storage
4. **TypeScript required** - All code must be TypeScript with proper types
5. **Accessible forms** - Use proper labels, ARIA attributes for form inputs
6. **Error boundaries** - Wrap components in error boundaries
7. **Loading states** - Show loading spinners during data fetch/submit

---

**Last reminder:** This is an INTERNAL tool for 10 people. Don't over-engineer it!
