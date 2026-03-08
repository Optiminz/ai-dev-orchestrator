# Project Constitution Template

> **INSTRUCTIONS:** Copy this file to the root of your new project and customize it. This document contains the non-negotiable principles and standards for your project. All AI-generated code, documentation, and analysis MUST adhere to these rules.

---

## 1. Core Principles (The "Why")

**Function over Aesthetics**
- This is a [PROJECT_TYPE — e.g., internal tool, web app, API, mobile app]. Speed, reliability, simplicity, and ease of use are prioritized over complex visual design or animations.
- Aesthetic design is subservient to function.

**User is Sovereign**
- All features must be driven by explicit user needs. We "Start with user needs".
- No features are built without clear user stories or acceptance criteria.

**Simplicity Beats Complexity**
- Avoid over-engineering. Prefer simple, maintainable solutions over complex or "clever" ones.
- When in doubt, choose the simpler approach.
- YAGNI (You Aren't Gonna Need It) - don't build features speculatively.

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

**Accessibility is Mandatory**
- All UI components and user flows must be accessible (WCAG 2.1 AA minimum).
- All interactive elements must be keyboard-navigable.
- All images must have alt text.
- Color contrast must meet accessibility standards.

---

## 2. AI Model Assumptions

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

## 3. Technical Stack (The "What")

### Mandated Technologies

**Frontend:**
- Framework: [FRONTEND_FRAMEWORK — e.g., React 18+, Vue 3, Svelte, Next.js]
- Language: TypeScript (strict mode enabled)
- File extensions: .tsx for React components, .ts for utilities
- Type imports: `import type { ... }` for type-only imports
- Styling: [FRONTEND_STYLING_LIBRARY — e.g., Tailwind CSS, CSS Modules, Styled Components]
- State Management: [STATE_MANAGEMENT_LIBRARY — e.g., Zustand, Redux Toolkit, Pinia]

**Backend:**
- Framework: [BACKEND_FRAMEWORK — e.g., FastAPI, Express.js, Django, Flask]
- Language: [BACKEND_LANGUAGE_AND_VERSION — e.g., Python 3.11+, Node.js 20+, Go 1.21+]
- API Style: [API_STYLE — e.g., REST, GraphQL, gRPC]

**Database:**
- Primary: [PRIMARY_DATABASE — e.g., PostgreSQL 15+, MongoDB 7+, SQLite]
- Caching: [CACHING_LAYER — e.g., Redis, Memcached, N/A]

**Infrastructure:**
- Platform: [DEPLOYMENT_PLATFORM — e.g., Docker, AWS Lambda, Vercel, Railway]
- CI/CD: [CICD_PIPELINE — e.g., GitHub Actions, GitLab CI, CircleCI]

### Prohibited Technologies

- ❌ [PROHIBITED_TECHNOLOGY_1 — e.g., jQuery - use modern vanilla JS or framework]
- ❌ [PROHIBITED_TECHNOLOGY_2 — e.g., Bootstrap - use Tailwind CSS]
- ❌ [PROHIBITED_TECHNOLOGY_3 — e.g., Class components in React - use functional components with hooks]
- ❌ [PROHIBITED_TECHNOLOGY_4 — e.g., Mongoose - use raw MongoDB driver or Prisma]

---

## 4. Type Sharing (Full-Stack TypeScript)

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

## 5. Coding Standards (The "How")

### Language & Style

**Language Version:**
- [PRIMARY_LANGUAGE_VERSION — e.g., TypeScript 5+ (strict mode enabled)]
- [SECONDARY_LANGUAGE_VERSION — e.g., Python 3.11+ with type hints, or remove if single-language]

**Style Guide:**
- [STYLE_GUIDE — e.g., Airbnb JavaScript Style Guide, PEP 8, Effective Go]

**Naming — Verbose Over Concise:**
- Prioritise clarity over brevity in all identifiers
- ✅ `getUserAuthenticationToken()` not `getToken()`
- ✅ `isEmailValidationSuccessful` not `isValid`
- ✅ `MAX_RETRY_ATTEMPTS` not `MAX_RETRIES`
- ✅ `handleUserProfileSubmit` not `handleSubmit`
- Rule: a new developer should understand the purpose of any variable or function without reading its implementation

**Linting & Formatting:**
- Linter: [LINTING_TOOL — e.g., ESLint, Pylint, golangci-lint]
- Formatter: [FORMATTING_TOOL — e.g., Prettier, Black, gofmt]
- All code must pass linting before commit.

### Code Organization

**File Structure:**
```
[PROJECT_DIRECTORY_STRUCTURE — define your project-specific directory layout here]
```

### Comments & Documentation

- Explain the **why** (intent), not the **what** (syntax)
- ❌ Bad: `// Loop through users`
- ✅ Good: `// Filter inactive users to reduce API payload size`
- Public functions need documentation headers; inline comments only for complex logic

### Error Handling

**API Responses:**
- All API endpoints must return consistent error structures:
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User-friendly error message",
    "details": { /* optional field-specific errors */ }
  }
}
```

**Exception Handling:**
- Never use bare `try/catch` or `try/except` blocks without specific error handling.
- Log all errors with context (user ID, request ID, timestamp).
- Never expose stack traces or internal errors to end users.

### Testing Requirements

**Coverage Thresholds:**
| Area | Minimum | Target |
|------|---------|--------|
| Business logic | 70% | 85% |
| Utility functions | 80% | 95% |
| API endpoints | 70% | 80% |
| UI components | 50% | 70% |

**"Adequate testing" checklist:**
- [ ] Happy path tested with realistic data
- [ ] Error cases tested (invalid input, network failures)
- [ ] Edge cases for user input (empty, too long, special chars)
- [ ] API contract validated (request/response shapes)
- [ ] Critical user flows have integration tests

**Testing philosophy:**
- Test behavior, not implementation
- Prefer integration tests over unit tests for API boundaries
- Mock external services, not internal modules

**Test Types:**
- Unit tests: [UNIT_TEST_FRAMEWORK — e.g., Jest, pytest, Go testing]
- Integration tests: [INTEGRATION_TEST_FRAMEWORK — e.g., Supertest, pytest with fixtures]
- E2E tests: [E2E_TEST_FRAMEWORK — e.g., Playwright, Cypress] (optional for internal tools)

---

## 6. Security & Compliance (The "Musts")

### Data Handling

**Personal Identifiable Information (PII):**
- ❌ Never log PII (emails, names, addresses, phone numbers).
- ❌ Never store PII in plain text.
- ✅ Always encrypt PII at rest.
- ✅ Always use HTTPS for data in transit.

**Secrets Management:**
- ❌ Never hardcode secrets, API keys, or credentials.
- ✅ All secrets must be stored in environment variables.
- ✅ Use a secrets manager in production (e.g., AWS Secrets Manager, HashiCorp Vault).

### Authentication & Authorization

**Authentication:**
- Method: [AUTH_METHOD — e.g., OAuth 2.0 with JWT tokens, Auth0, Firebase Auth]
- Session duration: [SESSION_DURATION — e.g., 24 hours with refresh tokens]
- Password requirements: [PASSWORD_POLICY — e.g., min 12 characters, must include special characters]

**Authorization:**
- All API endpoints must verify user permissions before execution.
- Use role-based access control (RBAC) or attribute-based access control (ABAC).

### Input Validation

**All user input must be validated:**
- ✅ Validate on both client and server side.
- ✅ Sanitize all inputs to prevent XSS attacks.
- ✅ Use parameterized queries to prevent SQL injection.
- ✅ Validate file uploads (type, size, content).

### Security Headers

**All HTTP responses must include:**
- `Content-Security-Policy`
- `X-Frame-Options: DENY`
- `X-Content-Type-Options: nosniff`
- `Strict-Transport-Security` (HSTS)

---

## 7. Git & Version Control

**Commit Messages:** Use conventional commits — `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`

**Branch Strategy:**
- `main`: production-ready code
- Feature branches: short-lived, branch from main, merged via PR

**PR Requirements:** All tests pass, linting clean, no merge conflicts

---

## 8. Performance Standards

### API Performance

**Response Times:**
- Target: 95th percentile < [API_RESPONSE_TIME_TARGET — e.g., 200ms]
- Maximum: [API_RESPONSE_TIME_MAXIMUM — e.g., 2 seconds]

**Database Queries:**
- Avoid N+1 queries (use eager loading, joins, or batching).
- All queries must use indexes for frequently accessed fields.
- Limit query result sets (pagination required for lists).

### Frontend Performance

**Bundle Size:**
- Target: Initial bundle < [FRONTEND_BUNDLE_SIZE_TARGET — e.g., 200KB gzipped]
- Code splitting required for routes.

**Images:**
- All images must be optimized (WebP format preferred).
- Use lazy loading for images below the fold.
- Provide responsive images with `srcset`.

**Core Web Vitals Targets:**
- LCP (Largest Contentful Paint): < 2.5s
- FID (First Input Delay): < 100ms
- CLS (Cumulative Layout Shift): < 0.1

---

## 9. Deployment & Operations

### Environment Strategy

**Environments:**
- `development`: Local development
- `staging`: Pre-production testing
- `production`: Live environment

**Environment Variables:**
- Never commit `.env` files to version control.
- Use `.env.example` as a template with dummy values.

### Monitoring & Logging

**Required Logging:**
- All API requests (method, path, status code, duration)
- All errors with stack traces and context
- All authentication events (login, logout, failed attempts)

**Log Levels:**
- `DEBUG`: Detailed information for debugging
- `INFO`: General informational messages
- `WARN`: Warning messages (non-critical issues)
- `ERROR`: Error messages (requires attention)

**Monitoring:**
- Service: [MONITORING_SERVICE — e.g., Sentry, Datadog, New Relic, CloudWatch]
- Alerts for: [MONITORING_ALERT_CONDITIONS — e.g., error rate > 1%, API latency > 2s, 5xx errors]

---

## 10. AI Coding Assistant Instructions

**When generating code for this project, you must:**

1. **Always reference this CONSTITUTION.md file** before writing any code.
2. **Ask clarifying questions** if the requirements conflict with these standards.
3. **Explain your reasoning** when making architectural decisions.
4. **Prioritize simplicity** over complexity or "clever" solutions.
5. **Include tests** for all new features or bug fixes.
6. **Add meaningful comments** that explain the "why", not the "what".
7. **Follow the established patterns** in the existing codebase.
8. **Never skip error handling** or input validation.
9. **Always consider security implications** of your code.
10. **Use the technical stack** defined in Section 3 - no substitutions without approval.

---

## Revision History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| [CONSTITUTION_DATE — YYYY-MM-DD] | 1.0 | Initial constitution | [AUTHOR_NAME] |

**Rule:** All constitution changes require:
1. Version number increment
2. Documented rationale for change
3. Review of dependent documentation (README, CLAUDE.md)

---

**Last Updated:** [LAST_UPDATED_DATE — YYYY-MM-DD]
