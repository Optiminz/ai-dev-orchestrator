# Task List Management

Guidelines for managing task lists in markdown files to track progress on completing a PRD.

> **Attribution:** This workflow is adapted from [ai-dev-tasks](https://github.com/malcolmryan/ai-dev-tasks) and integrated with the ai-dev-orchestrator framework.

## Task Implementation Protocol

### One Sub-Task at a Time
- **Do NOT** start the next sub-task until you ask the user for permission and they say "yes", "y", or "go"
- This ensures the user can review each piece before moving forward
- It prevents the AI from running ahead and building the wrong thing

### Completion Protocol

When you finish a **sub-task**, immediately mark it as completed by changing `[ ]` to `[x]`.

**If all subtasks underneath a parent task are now `[x]`, follow this sequence:**

1. **Run tests**: Execute the full test suite
   - Node/JavaScript: `npm test` or `yarn test`
   - Python: `pytest` or `python -m pytest`
   - Ruby: `bin/rails test` or `rspec`
   - Go: `go test ./...`
   - Use the testing approach defined in your `CONSTITUTION.md`

2. **Only if all tests pass**: Stage changes
   ```bash
   git add .
   ```

3. **Clean up before committing**:
   - Remove temporary files (`.tmp`, `debug.log`, etc.)
   - Remove commented-out code
   - Remove debug print statements
   - Verify no sensitive data (API keys, passwords) in code

4. **Commit with a descriptive message**:
   - Use conventional commit format (`feat:`, `fix:`, `refactor:`, `docs:`, `test:`, etc.)
   - Summarize what was accomplished in the parent task
   - List key changes and additions
   - Reference the task number and PRD context
   - Format as a single-line command using `-m` flags:

   ```bash
   git commit -m "feat: add user authentication" -m "- Implements login/logout endpoints" -m "- Adds JWT token generation" -m "- Includes unit tests for auth flow" -m "Related to T2 in user-auth PRD"
   ```

5. **Mark the parent task as completed**: Once committed, change the parent task `[ ]` to `[x]`

### After Each Sub-Task
- Stop and wait for the user's go-ahead
- Update the task list file
- Show the user what you completed
- Ask: "Ready for sub-task X.Y?"

## Task List Maintenance

### 1. Update as You Work

**Mark tasks completed:**
- Sub-tasks: Mark `[x]` immediately after finishing
- Parent tasks: Mark `[x]` only after all sub-tasks complete AND changes are committed

**Add new tasks as they emerge:**
```markdown
### Parent Task 3: Build Frontend Components
- [x] 3.1 Create Login component
- [x] 3.2 Create Dashboard component
- [ ] 3.3 Add form validation
- [ ] 3.3.1 NEW: Validate email format (discovered during 3.2)
- [ ] 3.3.2 NEW: Add password strength checker (discovered during 3.2)
- [ ] 3.4 Connect components to API
```

### 2. Maintain "Relevant Files" Section

At the bottom of your task list, keep a section tracking all files:

```markdown
## Relevant Files

### Created
- `src/components/Login.tsx` - User login form component
- `src/lib/auth.ts` - JWT token generation and validation
- `tests/auth.test.ts` - Authentication flow tests

### Modified
- `src/app/layout.tsx:15` - Added auth context provider
- `src/middleware.ts:8` - Added protected route middleware
- `package.json:12` - Added jsonwebtoken dependency
```

**Keep this updated** so you always know what files are part of this feature.

## Reference Your CONSTITUTION

Before implementing any sub-task, verify:
- **Tech stack alignment**: Use the frameworks/libraries specified in `CONSTITUTION.md`
- **Coding standards**: Follow the conventions defined in `CONSTITUTION.md`
- **Security requirements**: Implement security measures per `CONSTITUTION.md`
- **Testing approach**: Use the testing strategy from `CONSTITUTION.md`

**Example prompt:**
```
Before implementing sub-task 2.1, confirm this approach aligns with
the tech stack and security requirements in CONSTITUTION.md.
```

## AI Instructions

When working with task lists, you (the AI) must:

### Before Starting Work
1. Check `CONSTITUTION.md` for relevant standards and requirements
2. Identify which sub-task is next (the first `[ ]` that's not blocked)
3. Confirm with the user: "Ready to implement sub-task X.Y?"

### During Work
4. Implement ONLY the current sub-task (no running ahead)
5. Follow the coding standards from `CONSTITUTION.md`
6. Write tests according to the testing approach in `CONSTITUTION.md`

### After Finishing a Sub-Task
7. Mark the sub-task `[x]` immediately
8. Update the "Relevant Files" section
9. Show the user what was completed
10. If all sub-tasks in a parent are done: run tests, commit (if passing), mark parent `[x]`
11. Ask for permission to continue: "Sub-task X.Y complete. Ready for X.Y+1?"

### Task List Updates
12. Add newly discovered sub-tasks as they emerge
13. Keep the task list file current (update after each sub-task)
14. Never mark a task complete if tests fail or code doesn't work

## Interactive Mode (Recommended for Beginners)

For your first few features, use **interactive mode** when generating the task list:

### Step 1: Generate Parent Tasks Only
```markdown
I'll create parent tasks first:

- [ ] 1. Set up database schema
- [ ] 2. Create backend API endpoints
- [ ] 3. Build frontend components
- [ ] 4. Implement authentication
- [ ] 5. Add tests
- [ ] 6. Create documentation

Ready for sub-tasks? Reply "Go" to continue.
```

### Step 2: User Responds "Go"

### Step 3: Generate All Sub-Tasks
```markdown
Here are the detailed sub-tasks:

### 1. Set up database schema
- [ ] 1.1 Create users table in schema.sql
- [ ] 1.2 Create tasks table with foreign keys
- [ ] 1.3 Add indexes for performance
- [ ] 1.4 Run migration and test

### 2. Create backend API endpoints
- [ ] 2.1 Create GET /api/tasks endpoint
...
```

**Why interactive mode?**
- Lets you validate the high-level approach before details
- Easier to spot missing parent tasks
- Less overwhelming than seeing 40 sub-tasks at once

## Example Task List in Practice

```markdown
# Task List: User Authentication Feature

Reference PRD: `docs/prds/user-auth-prd.md`
Reference Constitution: `CONSTITUTION.md`

## Parent Tasks

- [x] 1. Set up database schema
- [x] 2. Create authentication API endpoints
- [ ] 3. Build frontend login components
- [ ] 4. Implement JWT token management
- [ ] 5. Add authentication tests
- [ ] 6. Create user documentation

## Detailed Sub-Tasks

### 1. Set up database schema ✅
- [x] 1.1 Create `users` table in `schema.sql` with email, password_hash, created_at
- [x] 1.2 Add unique constraint on email field
- [x] 1.3 Create migration file `migrations/001_users.sql`
- [x] 1.4 Run migration locally and verify

**Committed**: `feat: add users database schema` (commit abc123)

### 2. Create authentication API endpoints ✅
- [x] 2.1 Create `api/auth/register/route.ts` with POST endpoint
- [x] 2.2 Add password hashing with bcrypt in `lib/auth.ts`
- [x] 2.3 Create `api/auth/login/route.ts` with POST endpoint
- [x] 2.4 Add email validation before user creation
- [x] 2.5 Test endpoints with curl

**Committed**: `feat: add auth registration and login endpoints` (commit def456)

### 3. Build frontend login components 🔄 (In Progress)
- [x] 3.1 Create `components/LoginForm.tsx` with email and password inputs
- [x] 3.2 Add form validation (email format, password length)
- [ ] 3.3 Connect form to `/api/auth/login` endpoint
- [ ] 3.4 Add error handling for failed login
- [ ] 3.5 Create success redirect to dashboard

### 4. Implement JWT token management
- [ ] 4.1 Add JWT creation in `lib/auth.ts`
- [ ] 4.2 Create middleware for token verification
- [ ] 4.3 Add token refresh logic
- [ ] 4.4 Store token in httpOnly cookie

### 5. Add authentication tests
- [ ] 5.1 Create `tests/auth.test.ts`
- [ ] 5.2 Add tests for user registration (happy path)
- [ ] 5.3 Add tests for registration validation errors
- [ ] 5.4 Add tests for login (happy path)
- [ ] 5.5 Add tests for login failures (wrong password, missing user)
- [ ] 5.6 Add tests for JWT token generation

### 6. Create user documentation
- [ ] 6.1 Document registration endpoint in `docs/api/auth.md`
- [ ] 6.2 Document login endpoint
- [ ] 6.3 Add setup instructions for authentication

## Relevant Files

### Created
- `schema.sql` - Database schema with users table
- `migrations/001_users.sql` - Users table migration
- `api/auth/register/route.ts` - User registration endpoint
- `api/auth/login/route.ts` - User login endpoint
- `lib/auth.ts` - Authentication utilities (hashing, validation)
- `components/LoginForm.tsx` - Login form component

### Modified
- `package.json:18` - Added bcrypt dependency
- `package.json:19` - Added jsonwebtoken dependency
```

## Common Patterns

### When Tests Fail
```markdown
### 2. Create authentication API endpoints
- [x] 2.1 Create registration endpoint
- [x] 2.2 Add password hashing
- [x] 2.3 Create login endpoint
- [ ] 2.4 Fix failing test for duplicate email registration ❌
  - Error: Test expects 409 status, getting 500
  - Need to add duplicate email check before user creation
```

Don't mark the parent as complete. Don't commit. Fix the issue first.

### When Approach Changes Mid-Stream
```markdown
### 3. Build frontend login components
- [x] 3.1 Create LoginForm.tsx
- [x] 3.2 Add form validation
- [ ] 3.3 ~~Connect to /api/auth/login~~ REVISED: Use React Query for API calls
- [ ] 3.3.1 NEW: Set up React Query client
- [ ] 3.3.2 NEW: Create useLogin hook
- [ ] 3.3.3 NEW: Connect LoginForm to useLogin hook
```

It's okay to revise. Strike through old sub-tasks and add new ones.

### When You Discover Missing Work
```markdown
### 4. Implement JWT token management
- [x] 4.1 Add JWT creation
- [x] 4.2 Create verification middleware
- [ ] 4.3 Add token refresh logic
- [ ] 4.3.1 NEW: Create refresh token table in database (missed in schema phase)
- [ ] 4.3.2 NEW: Add refresh token generation
- [ ] 4.3.3 NEW: Create /api/auth/refresh endpoint
- [ ] 4.4 Store token in httpOnly cookie
```

Add the new sub-tasks where they logically fit.

## Tips for Success

### For Users
- **Review each sub-task** before saying "go" - catch issues early
- **Test frequently** - after every 2-3 sub-tasks, run your app
- **Keep task list updated** - it's your progress tracker and documentation
- **Don't skip tests** - they catch regressions before you deploy

### For AI Assistants
- **One at a time** - implement one sub-task, stop, wait for approval
- **Mark immediately** - mark `[x]` right after finishing, not later
- **Reference CONSTITUTION.md** - every implementation decision should align
- **Commit after parent completes** - keeps git history clean and logical
- **Communicate clearly** - tell the user what you did and what's next

---

Ready to build? Generate your task list with interactive mode and start implementing! 🚀
