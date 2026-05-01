# Constitution: [Your Project Name]

**Type:** Internal Tool
**Created:** [Date]
**Last Updated:** [Date]

---

## Project Overview

**Name:** [Your Project Name]

**Purpose:** [One paragraph describing what this tool does and why it exists]

**Example:**
```
Purpose: A simple task management tool for our marketing team to track
campaign deliverables, assign work, and monitor progress. Replaces our
current spreadsheet-based system which makes collaboration difficult.
```

---

## Core Principles

**Remember:** This is an internal tool. These principles keep us focused:

1. **It just needs to work** - Function over aesthetics
2. **Keep it simple** - No over-engineering or unnecessary features
3. **Fast iteration** - Ship quickly, improve based on real feedback
4. **Solve the specific problem** - Don't build a universal solution

**What "Simplicity" MEANS:**
- ✅ Choose proven, well-documented tools over cutting-edge experiments
- ✅ Prefer explicit code over "clever" abstractions
- ✅ One canonical way to do things, not multiple competing patterns
- ✅ Readable code over compact code
- ✅ Boring technology that works over exciting technology that might not

**What "Simplicity" does NOT MEAN:**
- ❌ Avoiding type safety (TypeScript adds safety, reduces debugging)
- ❌ Skipping validation libraries (Zod reduces code vs manual validation)
- ❌ Reinventing wheels to avoid dependencies
- ❌ Using weaker tools because they have fewer features

**Litmus test:** Will a developer new to the project understand this in 30 seconds?

---

## AI Model Assumptions

This constitution is designed for AI assistants with capabilities of:
- **Minimum:** Claude Sonnet 4 / GPT-4 / Gemini 1.5 Pro
- **Recommended:** Claude Opus 4+ for complex architecture decisions

**Assumed capabilities:**
- Strong TypeScript comprehension and generation
- Multi-file context understanding (50k+ tokens)
- Schema-aware code generation
- Ability to follow explicit constraints

**If using older/smaller models, consider:**
- More explicit inline comments explaining intent
- Smaller file sizes (<300 lines)
- Simpler type hierarchies (avoid deep generics)
- More frequent checkpoints and reviews

---

## Technical Stack

### Framework
**Choose one and specify version:**
- [ ] Next.js (version: ____)
- [ ] Express.js (Node.js version: ____)
- [ ] Flask (Python version: ____)
- [ ] FastAPI (Python version: ____)
- [ ] Rails (Ruby version: ____)
- [ ] Other: ________________

**Your choice:**
```
Framework: Next.js 14 with App Router
Runtime: Node.js 18
Language: TypeScript (strict mode enabled)
File extensions: .tsx for components, .ts for utilities
Type imports: import type { ... } for type-only imports
```

### Database
**Choose one:**
- [ ] Supabase (PostgreSQL)
- [ ] PostgreSQL (self-hosted)
- [ ] SQLite (simple, file-based)
- [ ] Replit Database
- [ ] MongoDB
- [ ] None (in-memory or localStorage only)

**Your choice:**
```
Database: Supabase (PostgreSQL)
Connection: Use Supabase client with environment variable
Migrations: Manual SQL files in db/migrations/
```

### Frontend/Styling
**Choose one:**
- [ ] Tailwind CSS (utility-first, fast)
- [ ] Plain CSS (simple, no framework)
- [ ] Bootstrap (component library)
- [ ] Material-UI (React components)
- [ ] None (default browser styles)

**Your choice:**
```
Styling: Tailwind CSS 3 via CDN
Why: Fast to prototype, no build config needed
UI: Functional > beautiful (forms, tables, basic layouts)
```

### Authentication
**Choose one:**
- [ ] Supabase Auth (email/password)
- [ ] Basic auth (simple username/password)
- [ ] Session-based (express-session)
- [ ] None (open access for internal network)

**Your choice:**
```
Authentication: Supabase Auth (email/password only)
Users: Manually added (no self-signup)
Sessions: 7-day expiration
```

---

## User Context

### Who Will Use This?
```
Users: [Number] people in [team/department]
Technical Level: [Non-technical / Mixed / Technical]
Access: [Web only / Mobile also / Desktop app]
Frequency: [Daily / Weekly / Monthly]
Location: [Office / Remote / Hybrid]
```

**Example:**
```
Users: 5 people in the marketing team
Technical Level: Non-technical (comfort with web apps, not with code)
Access: Web only (desktop and mobile browsers)
Frequency: Daily (10-20 tasks per person)
Location: Remote team, US time zones
```

### Use Cases
```
Primary use case: [Main workflow this tool enables]
Secondary use cases: [Other ways people will use it]
```

**Example:**
```
Primary: Track campaign tasks from creation to completion
Secondary:
- See who's working on what
- Filter tasks by status or assignee
- Mark tasks complete when done
```

---

## Coding Standards

### File Structure

Specify your project structure so the AI knows where to put files:

```
[your-project]/
├── src/
│   ├── app/              # Next.js app directory (or routes/ for Express)
│   ├── components/       # Reusable UI components
│   ├── lib/             # Utility functions
│   └── db/              # Database queries and models
├── public/              # Static assets
├── tests/               # Tests (if you add them)
├── db/
│   └── migrations/      # SQL migration files
├── .env.local           # Environment variables (gitignored)
└── README.md
```

### Code Style

**Keep it simple for internal tools:**

✅ **DO:**
- Clear function and variable names (even if verbose)
- Comments for "why", not "what"
- Error messages that actually help debug
- Consistent naming convention (camelCase, snake_case, etc.)

❌ **DON'T:**
- Over-abstract or create complex patterns
- Optimize prematurely
- Use obscure language features
- Build for theoretical future needs

**Example Code Style:**
```javascript
// Good for internal tool
async function getTasksByUser(userId) {
  // Fetch only incomplete tasks - complete tasks archived separately
  const tasks = await db.query(
    'SELECT * FROM tasks WHERE user_id = $1 AND status != $2',
    [userId, 'complete']
  );
  return tasks;
}

// Too complex for internal tool
class TaskRepository extends BaseRepository implements ITaskRepo {
  // Don't over-engineer for 5 users
}
```

### Error Handling

**Pattern to follow:**
```javascript
// API routes / backend
app.post('/api/tasks', async (req, res) => {
  try {
    // Validate input
    if (!req.body.title) {
      return res.status(400).json({ error: 'Task title is required' });
    }

    // Do the work
    const task = await createTask(req.body);

    // Return success
    res.json({ task });
  } catch (error) {
    // Log for debugging
    console.error('Error creating task:', error);

    // Return user-friendly error
    res.status(500).json({ error: 'Failed to create task. Please try again.' });
  }
});
```

### Database Patterns

**Keep queries simple:**
```javascript
// Good - straightforward and readable
const tasks = await supabase
  .from('tasks')
  .select('*')
  .eq('user_id', userId)
  .order('created_at', { ascending: false });

// Avoid complex joins unless necessary
// If you need data from multiple tables, sometimes it's okay
// to make multiple simple queries instead of one complex join
```

---

## Security Requirements

### Authentication & Authorization

**What level of auth do you need?**
```
Authentication: [How users log in]
Authorization: [Who can do what]
Session Management: [How long are sessions valid]
Password Requirements: [Minimum standards]
```

**Example:**
```
Authentication: Email/password via Supabase Auth
Authorization: All logged-in users can do everything (same team)
Session Management: 7-day sessions, no "remember me"
Password Requirements: Minimum 8 characters (Supabase default)
```

### Input Validation

**Always validate user inputs:**
```javascript
// Validate on the server, always
function validateTaskInput(data) {
  const errors = [];

  if (!data.title || data.title.trim() === '') {
    errors.push('Title is required');
  }

  if (data.title && data.title.length > 200) {
    errors.push('Title must be less than 200 characters');
  }

  // Add more validations as needed

  return errors;
}
```

### Data Protection

**For internal tools:**
```
Sensitive Data: [What data is sensitive?]
Encryption: [What needs encryption?]
Access Control: [Who can access what?]
Data Retention: [How long to keep data?]
```

**Example:**
```
Sensitive Data: None (just task descriptions and names)
Encryption: HTTPS only (via Vercel/Supabase)
Access Control: All team members see all tasks
Data Retention: Keep everything (no automated deletion)
```

### Environment Variables

**Never hardcode secrets:**
```bash
# .env.local (NEVER commit this file)
DATABASE_URL=postgresql://...
SUPABASE_URL=https://yourproject.supabase.co
SUPABASE_ANON_KEY=your-key-here
```

**Always use:**
```javascript
const dbUrl = process.env.DATABASE_URL;
// Never: const dbUrl = "postgresql://user:pass@...";
```

---

## Features & Scope

### Core Features (Must Have)

**What are the essential features?**
```
1. [Core feature 1]
2. [Core feature 2]
3. [Core feature 3]
```

**Example:**
```
1. Create tasks with title, description, assignee, due date
2. View all tasks (with filters: assigned to me, by status, by due date)
3. Mark tasks as complete
4. Edit task details
```

### Nice to Have (Phase 2)

**What can wait for version 2?**
```
- [Nice to have feature 1]
- [Nice to have feature 2]
```

**Example:**
```
- Task comments/notes
- File attachments
- Email notifications when assigned
- Task history/audit log
```

### Out of Scope (Not Building)

**Explicitly list what you WON'T build:**
```
- [Feature you won't build]
- [Another feature to avoid]
```

**Example:**
```
- Multi-tenant architecture (one team only)
- Real-time collaboration (refresh to see updates is fine)
- Mobile native app (responsive web is enough)
- Advanced analytics or reporting
- Integration with external tools (Slack, Jira, etc.)
- Role-based permissions (everyone is an admin)
```

---

## Type Sharing (Full-Stack TypeScript)

**Single Source of Truth:**
- All data types defined ONCE in `shared/schema.ts` (or `types/`)
- Frontend imports types directly from shared location
- No manual type duplication between frontend and backend
- API responses typed with schema types, never `any`

**Pattern:**
```typescript
// shared/schema.ts - AUTHORITATIVE
export type User = { id: number; name: string; email: string };

// Backend - imports from shared
import type { User } from '../shared/schema';

// Frontend - imports from shared
import type { User } from '@shared/schema';
```

**Prohibited:**
- ❌ Redefining types in frontend that exist in backend
- ❌ Using `any` for API responses
- ❌ Manual type guards when schema types exist

---

## Testing Approach

### For Internal Tools (Keep It Practical)

**Manual Testing (Primary):**
```
After implementing each feature:
1. Test the happy path (normal usage)
2. Test error cases (bad input, missing data)
3. Test on desktop browser
4. Quick test on mobile browser
5. Ask a team member to try it
```

**Automated Testing (Optional but recommended):**

**Coverage Thresholds (if adding automated tests):**
| Area | Minimum | Target |
|------|---------|--------|
| Business logic | 60% | 75% |
| Utility functions | 70% | 85% |
| API endpoints | 60% | 70% |

**"Adequate testing" checklist:**
- [ ] Happy path tested with realistic data
- [ ] Error cases tested (invalid input, network failures)
- [ ] Edge cases for user input (empty, too long, special chars)
- [ ] API contract validated (request/response shapes)

**Testing philosophy:**
- Test behavior, not implementation
- Manual testing is fine for internal tools
- Add automated tests if bugs become frequent

**Example:**
```
Testing: Mostly manual
- Test each new feature in dev environment
- Have Sarah (team lead) test before shipping
- Fix bugs as reported (usually < 5 per feature)

Automated: None initially, may add Jest tests if bugs become frequent
```

---

## Deployment

### Where Will This Run?

**Choose your deployment platform:**
```
Platform: [Vercel / Netlify / Replit / Heroku / AWS / Other]
URL: [your-app.vercel.app or custom domain]
Environment: [Staging / Production only / Both]
```

**Example:**
```
Platform: Vercel (free tier)
URL: marketing-tasks.vercel.app
Environment: Production only (no staging, low traffic)
Deployment: Automatic on push to main branch
Database: Supabase (hosted, managed)
```

### Environment Configuration

```
Development: Local (npm run dev)
Production: [Platform] with these env vars:
- DATABASE_URL
- SUPABASE_URL
- SUPABASE_ANON_KEY
```

---

## Performance Expectations

### For Internal Tools (Realistic Goals)

**What's "good enough" for internal use?**
```
Page Load: [Under X seconds]
API Response: [Under X milliseconds]
Concurrent Users: [Support X users at once]
Uptime: [X% uptime goal]
```

**Example:**
```
Page Load: Under 3 seconds (on good wifi)
API Response: Under 1 second for most actions
Concurrent Users: 5 users max (whole team)
Uptime: 95% is fine (can tolerate some downtime)

Note: No need for caching, CDN, or performance optimization
unless we actually experience slowness.
```

---

## Documentation

### What Documentation Do You Need?

**For internal tools, keep docs light:**

**README.md (Required):**
```
- What the tool does
- How to run it locally
- How to deploy it
- Environment variables needed
- Who to ask for help
```

**Code Comments (Helpful):**
```
- Complex business logic
- Non-obvious workarounds
- Integration quirks
```

**API Documentation (Optional):**
```
Only if you have an API:
- Endpoint list
- Request/response examples
- Error codes
```

**Example:**
```
Documentation Plan:
- README.md: Setup and deployment instructions
- Code comments: Why we're doing something, not what
- No formal API docs (only 5 internal users)
- Slack channel #marketing-tasks for questions
```

---

## Third-Party Integrations

### What External Services Will You Use?

**List any APIs or services:**
```
Service: [Name]
Purpose: [What it does]
API Key: [Where stored - environment variable name]
```

**Example:**
```
Supabase:
- Purpose: Database and authentication
- Config: SUPABASE_URL and SUPABASE_ANON_KEY in .env.local

Resend (Future):
- Purpose: Email notifications (phase 2)
- Config: RESEND_API_KEY
- Not building yet (out of scope for v1)
```

---

## Development Workflow

### How Should Features Be Built?

**Process to follow:**
```
1. Create PRD (using ai-framework/quick-start/simple-workflow.md)
2. Generate task list (using ai-framework/quick-start/process-task-list.md)
3. Implement tasks one at a time
4. Test manually after each task
5. Deploy when feature is complete
6. Gather feedback from team
7. Iterate
```

**Git Workflow:**
```
Branches: [main only / feature branches / other]
Commits: [After each task / after each feature / ad-hoc]
Pull Requests: [Required / Optional / Not used]
```

**Example:**
```
Git: Simple workflow
- Work directly on main branch (small team, low risk)
- Commit after completing each parent task
- Use conventional commits: feat:, fix:, chore:
- Deploy automatically via Vercel on push to main

No pull requests needed (just us, internal tool)
```

---

## Success Criteria

### How Do You Know It's Working?

**Metrics and feedback:**
```
Success looks like:
1. [Measurable outcome 1]
2. [Measurable outcome 2]
3. [User feedback indicator]
```

**Example:**
```
Success Criteria:
1. All 5 team members use it daily within 2 weeks
2. Task completion rate visible (we know what's done)
3. Team says it's better than our old spreadsheet
4. We add at least 20 tasks per week
5. Zero critical bugs after 1 month

Failure signals:
- Team reverts to old spreadsheet
- More than 2 critical bugs per week
- Takes > 5 minutes to add/complete a task
```

---

## Maintenance Plan

### Who Maintains This?

**Ongoing responsibilities:**
```
Owner: [Name / Role]
Backup: [Name / Role]
Updates: [Frequency - weekly / monthly / as-needed]
Bug Fixes: [SLA - within X days]
Feature Requests: [Process for requesting new features]
```

**Example:**
```
Owner: Alex (built it, knows the code)
Backup: Jordan (can debug if Alex is unavailable)
Updates: As needed (not on a schedule)
Bug Fixes: Within 2 business days for critical, 1 week for minor
Feature Requests: Add to #marketing-tasks channel, discuss in weekly meeting
```

---

## Known Constraints & Trade-offs

### What Are We Accepting?

**Be honest about limitations:**
```
Constraint: [What we can't do]
Why: [Reason for constraint]
Impact: [What this means for users]
Mitigation: [How we'll work around it]
```

**Example:**
```
Constraint: No real-time updates (must refresh to see changes)
Why: Keeping it simple, avoiding WebSocket complexity
Impact: User A won't see User B's changes until refresh
Mitigation: Refresh button prominently displayed

Constraint: No mobile app (responsive web only)
Why: Not worth the effort for 5 users
Impact: Mobile browser experience may not be perfect
Mitigation: Optimize for mobile web, test on iOS/Android

Constraint: Only one workspace (can't separate projects)
Why: Building for one team only
Impact: All tasks in one big list (use filters)
Mitigation: Good filtering and search
```

---

## Revision History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| [YYYY-MM-DD] | 1.0 | Initial constitution | [Your Name] |

**Rule:** All constitution changes require:
1. Version number increment
2. Documented rationale for change
3. Review of dependent documentation (README, CLAUDE.md)

**Example of tracking changes:**
```
v1.1 - 2025-02-15 - Added email notifications
- Added Resend integration for email
- Updated feature scope to include notifications
- Reviewed by: Team Lead
```

---

## Questions for the AI

When building features, AI assistants should follow this Constitution and:

### Always:
- ✅ Reference this CONSTITUTION.md in every prompt
- ✅ Follow the specified tech stack (don't suggest alternatives)
- ✅ Keep code simple and functional (no over-engineering)
- ✅ Validate user inputs on the server
- ✅ Use environment variables for secrets
- ✅ Follow the file structure defined above
- ✅ Ask clarifying questions if requirements are unclear

### Never:
- ❌ Suggest features listed in "Out of Scope"
- ❌ Hardcode API keys or secrets
- ❌ Build complex abstractions for small use cases
- ❌ Optimize prematurely
- ❌ Implement features without confirming with the user first
- ❌ Skip error handling
- ❌ Forget to mark sub-tasks complete [x] after finishing them

---

## Ready to Build!

This Constitution is your project's source of truth. Reference it in all AI prompts:

```
@CONSTITUTION.md
@ai-framework/quick-start/simple-workflow.md

I want to build [feature]. Help me create a PRD.
```

**Next Steps:**
1. Fill in all the placeholders above (marked with [brackets])
2. Review with your team (if applicable)
3. Save this as `CONSTITUTION.md` in your project root
4. Start building with [Quick Start Guide](../quick-start/README.md)

🚀 **Let's ship something!**
