# Constitution: [Your Client App Name]

**Type:** Client Application
**Created:** [Date]
**Last Updated:** [Date]

---

## Project Overview

**Name:** [Your Application Name]

**Purpose:** [One paragraph describing what this application does and the problem it solves]

**Target Market:** [Who are your customers? What industry?]

**Example:**
```
Purpose: A SaaS analytics dashboard that helps e-commerce businesses track
customer behavior, conversion rates, and revenue metrics in real-time.

Target Market: Small to medium e-commerce businesses (10-500 employees)
looking for affordable, easy-to-use analytics.
```

---

## Core Principles

**This is a client-facing application. These principles guide all decisions:**

1. **Quality First** - This represents your brand and reputation
2. **Security is Non-Negotiable** - Protect customer data at all costs
3. **Professional Polish** - UI/UX must be intuitive and beautiful
4. **Scalability Matters** - Build to handle growth
5. **Documentation Required** - Users and developers need clear docs
6. **Simplicity Over Complexity** - Proven tools over cutting-edge experiments

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
**Specify your primary framework and version:**
```
Framework: [Next.js 14 / React 18 / Vue 3 / Angular / etc.]
Version: [Exact version]
Why: [Reason for choosing this]
```

**Example:**
```
Framework: Next.js 14 with App Router
Runtime: Node.js 20 LTS
Why: SEO support, server components, excellent DX, production-proven
```

### Backend/API
```
API Framework: [Next.js API Routes / Express / FastAPI / Django REST / etc.]
Database: [PostgreSQL / MySQL / MongoDB / etc.]
ORM: [Prisma / Drizzle / TypeORM / Mongoose / etc.]
Caching: [Redis / None / In-memory]
```

**Example:**
```
API: Next.js 14 API Routes (serverless functions)
Database: PostgreSQL 15 via Supabase
ORM: Prisma (type-safe, excellent migrations)
Caching: Redis (Upstash) for session data and rate limiting
```

### Frontend
```
UI Framework: [React / Vue / Svelte / etc.]
Styling: [Tailwind / CSS Modules / Styled Components / MUI / etc.]
Component Library: [shadcn/ui / MUI / Ant Design / Custom]
State Management: [Zustand / Redux / Context API / TanStack Query]
Forms: [React Hook Form / Formik / etc.]
Validation: [Zod / Yup / Joi]
```

**Example:**
```
UI: React 18 with TypeScript (strict mode enabled)
File extensions: .tsx for components, .ts for utilities
Type imports: import type { ... } for type-only imports
Styling: Tailwind CSS 3 + shadcn/ui components
State: TanStack Query for server state, Zustand for client state
Forms: React Hook Form + Zod for validation
Icons: Lucide React
```

### Authentication & Authorization
```
Auth Provider: [Clerk / Auth0 / Supabase Auth / NextAuth / Custom]
Strategy: [JWT / Session / OAuth / etc.]
Social Logins: [Google / GitHub / etc.]
MFA: [Yes / No / Future]
```

**Example:**
```
Auth: Clerk (managed auth, handles edge cases)
Strategy: Session-based with secure httpOnly cookies
Social: Google, GitHub, Microsoft
MFA: Email OTP + Authenticator app (required for admin roles)
RBAC: Custom roles (admin, user, viewer) via Clerk metadata
```

### Payment Processing (if applicable)
```
Payment Provider: [Stripe / Paddle / LemonSqueezy / etc.]
Billing Model: [Subscription / One-time / Usage-based]
Currency Support: [USD / Multi-currency]
```

**Example:**
```
Payments: Stripe
Model: Subscription (monthly/annual plans)
Plans: Starter ($29/mo), Pro ($99/mo), Enterprise (custom)
Webhooks: Handle subscription.created, invoice.paid, customer.deleted
```

---

## User Context

### Target Users
```
Primary Users: [Who will use this the most?]
User Personas: [2-3 key persona descriptions]
Technical Level: [Non-technical / Mixed / Technical]
Access Methods: [Web / Mobile web / Native app / API]
Geographic Distribution: [Local / National / Global]
```

**Example:**
```
Primary Users: E-commerce marketing managers and analysts

Personas:
1. Sarah (Marketing Manager) - Non-technical, needs dashboards and reports
2. Mike (Data Analyst) - Semi-technical, wants to export data and create custom reports
3. Alex (CTO) - Technical, needs API access and integration capabilities

Technical Level: Mostly non-technical (80%), some technical power users
Access: Web (desktop and mobile browsers), future native mobile app
Geographic: Global (US, Europe, APAC) - need i18n support
```

### Scale Expectations
```
Launch: [X users]
Year 1: [X users]
Year 3: [X users]
Peak Concurrent: [X users at once]
Data Volume: [X records / requests per day]
```

**Example:**
```
Launch: 50 beta customers (~500 users)
Year 1: 500 customers (~5,000 users)
Year 3: 2,000 customers (~20,000 users)
Peak Concurrent: 500 users (during business hours)
Data Volume: 1M API requests/day, 100GB data storage
```

---

## Architecture

### Application Architecture
```
Pattern: [Monolith / Microservices / Serverless / Hybrid]
Why: [Reasoning for this choice]
```

**Example:**
```
Pattern: Monolithic Next.js application (for now)
Why: Faster development, easier deployment, sufficient for year 1-2 scale
Future: May split API into separate service at 10,000+ users

Deployment: Vercel (frontend + API routes)
Database: Supabase (managed PostgreSQL)
File Storage: Vercel Blob
Background Jobs: Inngest (for async tasks)
```

### Data Architecture
```
Primary Database: [Name and purpose]
Read Replicas: [Yes / No]
Data Warehouse: [For analytics - Snowflake / BigQuery / None]
Search: [Algolia / Elasticsearch / PostgreSQL full-text]
Real-time: [WebSockets / Server-Sent Events / Polling]
```

**Example:**
```
Primary DB: PostgreSQL (Supabase) for all app data
Read Replicas: No (not needed yet, Supabase handles this)
Analytics: BigQuery (export data daily for long-term analysis)
Search: PostgreSQL full-text search (pg_trgm) for now, Algolia if needed
Real-time: Server-Sent Events for dashboard updates
```

---

## Security Requirements

### Authentication
```
- Email/Password: [Minimum requirements]
- Password Policy: [Length, complexity, rotation]
- Session Management: [Duration, refresh strategy]
- Account Recovery: [Email / SMS / Security questions]
- Account Lockout: [After X failed attempts]
```

**Example:**
```
Auth via Clerk:
- Password: Minimum 12 characters, requires upper, lower, number, symbol
- Session: 7 days, sliding window (extends on activity)
- Recovery: Email-based password reset with 1-hour expiry
- Lockout: 5 failed attempts = 15-minute lockout
- Password Reuse: Prevent reuse of last 5 passwords
```

### Authorization
```
Role-Based Access Control (RBAC):
- Roles: [List roles and what they can do]
- Permissions: [Granular permissions]
- Multi-tenancy: [How tenants are isolated]
```

**Example:**
```
Roles:
- Owner: Full access, billing, user management
- Admin: Full access except billing
- Editor: Create/edit/delete content
- Viewer: Read-only access

Multi-tenancy: Row-level security (RLS) in Supabase
- Every table has workspace_id
- RLS policies enforce workspace isolation
- No cross-workspace data access possible
```

### Data Protection
```
Encryption at Rest: [Yes / No - where]
Encryption in Transit: [TLS version]
PII Handling: [How is PII protected]
Data Retention: [How long data is kept]
Data Deletion: [Hard delete / Soft delete / Retention period]
Compliance: [GDPR / HIPAA / SOC2 / etc.]
```

**Example:**
```
Encryption at Rest: Yes (Supabase default, AES-256)
Encryption in Transit: TLS 1.3 minimum
PII: Encrypted in database, never logged
Audit Logs: 90-day retention for compliance
Soft Delete: 30-day retention before hard delete (GDPR right to be forgotten)
Compliance: GDPR-compliant, SOC2 Type II in year 2
```

### API Security
```
Rate Limiting: [Requests per minute/hour]
API Authentication: [API keys / OAuth / JWT]
CORS: [Allowed origins]
Input Validation: [How enforced]
SQL Injection Prevention: [ORM / Parameterized queries]
XSS Prevention: [CSP / Sanitization]
CSRF Protection: [Tokens / SameSite cookies]
```

**Example:**
```
Rate Limiting:
- Authenticated: 1000 req/hour per user
- Anonymous: 100 req/hour per IP
- Webhooks: 10,000 req/hour

API Auth: Bearer tokens (JWT) with 1-hour expiry
CORS: Strict allow-list of customer domains
Input Validation: Zod schemas on all API inputs
SQL Injection: Prisma ORM (parameterized queries only)
XSS: React's built-in escaping + Content Security Policy
CSRF: SameSite=Strict cookies + CSRF tokens for mutations
```

---

## Code Quality Standards

### TypeScript Configuration
```
Strict Mode: Yes (required)
No Implicit Any: Yes (required)
```

**Example:**
```typescript
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "noUncheckedIndexedAccess": true
  }
}
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

### File Structure
```
src/
├── app/                  # Next.js app directory
│   ├── (auth)/          # Auth routes group
│   ├── (dashboard)/     # Dashboard routes group
│   └── api/             # API routes
├── components/
│   ├── ui/              # shadcn/ui components
│   ├── dashboard/       # Dashboard-specific components
│   └── marketing/       # Marketing page components
├── lib/
│   ├── db/              # Database utilities
│   ├── auth/            # Auth utilities
│   ├── api/             # API clients
│   └── utils/           # General utilities
├── types/               # TypeScript types
├── hooks/               # Custom React hooks
└── styles/              # Global styles
```

### Coding Conventions
```
Naming:
- Components: PascalCase (UserProfile.tsx)
- Functions: camelCase (getUserData)
- Constants: UPPER_SNAKE_CASE (API_BASE_URL)
- Types: PascalCase (User, UserProfile)

Comments:
- JSDoc for all public functions
- Inline comments for complex logic only
- TODO comments must include ticket number

Error Handling:
- Never swallow errors silently
- Log errors with context (user ID, request ID)
- Return user-friendly error messages
- Use custom error classes
```

**Example:**
```typescript
/**
 * Fetches user profile data with caching
 * @param userId - The unique user identifier
 * @returns User profile object
 * @throws {UserNotFoundError} If user doesn't exist
 * @throws {DatabaseError} If database query fails
 */
async function getUserProfile(userId: string): Promise<UserProfile> {
  try {
    const cached = await redis.get(`user:${userId}`);
    if (cached) return JSON.parse(cached);

    const user = await db.user.findUnique({ where: { id: userId } });
    if (!user) throw new UserNotFoundError(userId);

    await redis.set(`user:${userId}`, JSON.stringify(user), 'EX', 3600);
    return user;
  } catch (error) {
    if (error instanceof UserNotFoundError) throw error;
    logger.error('Failed to fetch user profile', { userId, error });
    throw new DatabaseError('Failed to fetch user profile');
  }
}
```

---

## Testing Strategy

### Unit Tests
```
Framework: [Vitest / Jest / etc.]
Coverage Target: [X%]
What to Test: [Business logic, utilities, helpers]
```

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

**Example:**
```
Framework: Vitest (fast, modern)
Coverage: 80% for src/lib/, 60% overall
Focus: Business logic, data transformations, utilities
Mock: External APIs, database calls
Run: Pre-commit hook + CI
```

### Integration Tests
```
Framework: [Playwright / Cypress / etc.]
What to Test: [API endpoints, critical user flows]
```

**Example:**
```
Framework: Playwright
Tests:
- API endpoints (all CRUD operations)
- Auth flows (signup, login, logout, password reset)
- Payment flows (subscription creation, cancellation)
- Data integrity (multi-tenant isolation)

Run: CI only (too slow for pre-commit)
```

### E2E Tests
```
Framework: [Playwright / Cypress]
Critical Paths: [List 3-5 critical user journeys]
```

**Example:**
```
Framework: Playwright
Critical Paths:
1. New user signup → onboarding → first dashboard view
2. Admin creates workspace → invites user → user accepts → accesses dashboard
3. User upgrades plan → enters payment → subscription active → features unlocked
4. User creates report → exports data → receives file

Run: Nightly + before prod deployments
```

### Manual QA Checklist
```
Before each release:
- [ ] Test on Chrome, Firefox, Safari
- [ ] Test on mobile (iOS and Android)
- [ ] Test all payment flows in Stripe test mode
- [ ] Verify email notifications send correctly
- [ ] Check error messages are user-friendly
- [ ] Verify analytics tracking works
```

---

## Performance Requirements

### Page Load Targets
```
Initial Page Load: [X seconds]
Time to Interactive: [X seconds]
Largest Contentful Paint: [X seconds]
Core Web Vitals: [Pass / Fail]
```

**Example:**
```
Targets (on 4G, mid-tier device):
- Initial Load: < 2 seconds
- Time to Interactive: < 3 seconds
- LCP: < 2.5 seconds
- FID: < 100ms
- CLS: < 0.1

All pages must pass Core Web Vitals (Green in PageSpeed Insights)
```

### API Performance
```
API Response Time: [Pxx] < [X ms]
Database Query Time: [Pxx] < [X ms]
Slow Query Threshold: [X ms]
```

**Example:**
```
API Performance:
- P50: < 100ms
- P95: < 500ms
- P99: < 1000ms

Slow queries (>200ms) trigger alerts
Use database indexes on all foreign keys and frequently queried columns
```

### Optimization Strategies
```
- Images: [Next.js Image optimization / CDN]
- Fonts: [Self-hosted / Google Fonts / Variable fonts]
- Code Splitting: [Route-based / Component-based]
- Caching: [Strategy - SWR / ISR / CDN]
- Bundle Size: [Target size - X KB]
```

**Example:**
```
Images: next/image with Vercel Image Optimization
Fonts: Self-hosted variable fonts (Inter) for GDPR compliance
Code Splitting: Automatic route-based via Next.js
Caching:
  - Static pages: ISR (revalidate every 60s)
  - User data: SWR (stale-while-revalidate)
  - API responses: Redis cache (5-minute TTL)
Bundle Size: < 200 KB initial bundle (excluding images)
```

---

## Monitoring & Observability

### Application Monitoring
```
APM Tool: [Datadog / New Relic / Sentry / Vercel Analytics]
Error Tracking: [Sentry / Rollbar / etc.]
Uptime Monitoring: [Ping / Better Stack / etc.]
Log Aggregation: [Datadog / Logtail / etc.]
```

**Example:**
```
APM: Vercel Analytics + Web Vitals
Error Tracking: Sentry
- Capture all uncaught errors
- Include user context (ID, workspace, plan tier)
- Alert on-call engineer for critical errors
- Group similar errors to reduce noise

Uptime: Better Stack (formerly Uptime Robot)
- Ping /api/health every 60 seconds
- Alert if down for 2 consecutive checks

Logs: Vercel + Datadog
- All API errors logged to Datadog
- Searchable by user, workspace, endpoint
```

### Analytics
```
Product Analytics: [Mixpanel / Amplitude / PostHog]
Web Analytics: [Plausible / Google Analytics / Fathom]
What to Track: [Key events]
```

**Example:**
```
Product: PostHog (GDPR-friendly, self-hostable)
Events:
- User signup (source, plan)
- Dashboard viewed (workspace, date range)
- Report created (type, filters used)
- Data exported (format, size)
- Subscription upgraded/downgraded (from_plan, to_plan)

Web: Plausible (privacy-focused, GDPR-compliant)
- Page views
- Referrer sources
- Geography (country-level only)
```

### Alerting
```
Alert Channels: [Slack / PagerDuty / Email]
Alert Conditions: [When to alert]
On-Call Rotation: [Who gets alerts]
```

**Example:**
```
Channels: Slack (#alerts) + PagerDuty for critical
Alerts:
- Critical: API error rate > 1% for 5 min
- Critical: Database connections > 80% for 2 min
- Warning: API P95 latency > 500ms for 10 min
- Warning: Disk usage > 70%

On-Call: Engineering team (rotating weekly)
```

---

## Deployment & DevOps

### Environments
```
Development: [Where devs work]
Staging: [Pre-production testing]
Production: [Live customer environment]
```

**Example:**
```
Development: Local (localhost:3000)
- Uses Supabase dev project
- Stripe test mode
- Debug logging enabled

Staging: Vercel preview deployments (staging.yourapp.com)
- Uses Supabase staging project
- Stripe test mode
- Production-like data (anonymized)
- Auto-deployed from 'develop' branch

Production: Vercel production (app.yourapp.com)
- Uses Supabase production project
- Stripe live mode
- Auto-deployed from 'main' branch
- Requires passing E2E tests
```

### CI/CD Pipeline
```
On Pull Request:
- [ ] Lint (ESLint)
- [ ] Type check (TypeScript)
- [ ] Unit tests (Vitest)
- [ ] Build succeeds
- [ ] Preview deployment

On Merge to Main:
- [ ] All PR checks pass
- [ ] Integration tests
- [ ] E2E tests (smoke tests)
- [ ] Deploy to production
- [ ] Run post-deployment health check
```

### Database Migrations
```
Tool: [Prisma Migrate / Drizzle Kit / Flyway]
Strategy: [How migrations are run]
Rollback Plan: [How to rollback if needed]
```

**Example:**
```
Migrations: Prisma Migrate
Process:
1. Create migration locally: npx prisma migrate dev
2. Test migration on local DB
3. Commit migration files to git
4. Staging: Runs automatically on deploy (prisma migrate deploy)
5. Production: Runs automatically on deploy (with rollback plan)

Rollback:
- Revert Git commit
- Redeploy previous version
- Manually fix data if needed (have backup!)

Backups: Supabase automatic daily backups (7-day retention)
```

---

## Documentation

### User Documentation
```
Required:
- [ ] Getting Started guide
- [ ] Feature documentation for each major feature
- [ ] FAQs
- [ ] Troubleshooting guide
- [ ] Video tutorials (optional but recommended)

Platform: [Gitbook / Readme.io / Custom docs site]
```

**Example:**
```
User Docs: Custom Next.js site at docs.yourapp.com
Structure:
- Getting Started (signup, onboarding, first dashboard)
- Guides (how to create reports, invite users, export data)
- Reference (all features documented)
- API Documentation (for technical users)
- FAQs
- Troubleshooting

Maintained by: Product team
Updated: With every major feature release
```

### Developer Documentation
```
Required:
- [ ] README with setup instructions
- [ ] Architecture documentation
- [ ] API documentation (if public API)
- [ ] Contributing guide
- [ ] Code comments (JSDoc)

Platform: [In repo / Wiki / Separate docs site]
```

**Example:**
```
Dev Docs: In-repo (docs/ folder)
- README.md: Setup, running locally, deploying
- ARCHITECTURE.md: System design, data flow
- API.md: API endpoints, authentication, examples
- CONTRIBUTING.md: Code style, PR process, testing

API Docs: Auto-generated from JSDoc via Swagger/OpenAPI
Published at: api-docs.yourapp.com
```

---

## Support & Maintenance

### Support Channels
```
Tier 1: [In-app chat / Email / Knowledge base]
Tier 2: [Email / Dedicated support rep]
Tier 3: [Escalation to engineering]
SLA: [Response time by plan tier]
```

**Example:**
```
Support:
- In-app chat (Intercom) - All users
- Email (support@yourapp.com) - All users
- Dedicated Slack channel - Enterprise customers only

SLA:
- Starter: 48-hour response
- Pro: 24-hour response, 8-hour for critical
- Enterprise: 4-hour response, 1-hour for critical

Escalation: Support → Engineering Lead → CTO
```

### Maintenance Windows
```
Planned Maintenance: [Day/time, frequency]
Notification: [How much notice]
Downtime Target: [Hours per month]
```

**Example:**
```
Planned Maintenance: First Sunday of month, 2-4am UTC
Notification: 7 days advance notice (email + in-app banner)
Downtime Target: < 4 hours/year (99.95% uptime)

Emergency Maintenance: As needed, with 1-hour notice if possible
Status Page: status.yourapp.com (powered by Better Stack)
```

---

## Compliance & Legal

### Data Privacy
```
Privacy Policy: [URL]
GDPR Compliance: [Yes / No / In progress]
CCPA Compliance: [Yes / No / N/A]
Cookie Consent: [Required / Implemented]
Data Processing Agreement: [For enterprise customers]
```

**Example:**
```
Privacy: yourapp.com/privacy (reviewed by legal)
GDPR: Full compliance
- Right to access: Self-serve export in settings
- Right to deletion: Self-serve account deletion
- Data portability: Export to JSON/CSV
- Consent: Explicit opt-in for marketing emails

CCPA: Compliant (Do Not Sell My Info link in footer)
Cookies: Cookie banner via Cookiebot (required consent)
DPA: Available for Enterprise plan customers
```

### Terms of Service
```
ToS: [URL]
Acceptable Use Policy: [What's not allowed]
SLA: [Uptime guarantee]
Data Retention: [How long data is kept]
```

### Security & Compliance
```
Security Audits: [Frequency]
Penetration Testing: [Annual / Quarterly]
SOC2: [Yes / No / In progress]
ISO 27001: [Yes / No / Future]
```

**Example:**
```
Security:
- Internal security review: Quarterly
- External penetration test: Annual (before SOC2 audit)
- Vulnerability scanning: Continuous (Snyk)

Compliance:
- SOC2 Type II: Starting year 2
- ISO 27001: Future (year 3)
- HIPAA: Not applicable

Bug Bounty: HackerOne program (starting year 2)
Disclosure: security@yourapp.com (24-hour response SLA)
```

---

## Disaster Recovery

### Backup Strategy
```
Database Backups: [Frequency, retention]
File Storage Backups: [Frequency, retention]
Configuration Backups: [What's backed up]
Backup Testing: [How often tested]
```

**Example:**
```
Database: Supabase automatic backups
- Frequency: Daily at 2am UTC
- Retention: 7 days (point-in-time recovery for 7 days)
- Test restore: Monthly

File Storage: Vercel Blob automatic backups
- Frequency: Continuous (S3-backed)
- Retention: Permanent (users own their files)

Configs: Stored in Git (version controlled)
Secrets: Backed up in 1Password team vault
```

### Disaster Recovery Plan
```
RTO (Recovery Time Objective): [X hours]
RPO (Recovery Point Objective): [X hours of data loss acceptable]
Runbook: [Location of DR runbook]
```

**Example:**
```
RTO: 4 hours (from incident to fully operational)
RPO: 24 hours (max 1 day of data loss, typically < 1 hour)

DR Runbook: docs/runbooks/disaster-recovery.md
Scenarios covered:
1. Database failure → Restore from backup
2. Vercel outage → Failover to AWS (future)
3. Supabase outage → Wait (no self-hosted fallback yet)
4. Data corruption → Point-in-time recovery

Annual DR drill: Full recovery simulation
```

---

## Roadmap & Future Considerations

### Phase 1 (Launch)
```
- [ ] Core features (list)
- [ ] Authentication and authorization
- [ ] Payment integration
- [ ] Basic documentation
```

### Phase 2 (Month 3-6)
```
- [ ] Advanced features (list)
- [ ] API for integrations
- [ ] Enhanced analytics
- [ ] Mobile app (if applicable)
```

### Phase 3 (Year 2)
```
- [ ] Enterprise features (SSO, SCIM provisioning)
- [ ] SOC2 compliance
- [ ] Multi-region deployment
- [ ] Advanced customization
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

---

## Questions for the AI

When building features, AI assistants should follow this Constitution and:

### Always:
- ✅ Reference CONSTITUTION.md in every prompt
- ✅ Write TypeScript with strict type safety
- ✅ Include comprehensive error handling
- ✅ Add JSDoc comments for public functions
- ✅ Implement proper authentication/authorization checks
- ✅ Validate all user inputs (Zod schemas)
- ✅ Write unit tests for business logic
- ✅ Follow security best practices (OWASP Top 10)
- ✅ Consider scalability (will this work at 10x scale?)
- ✅ Add proper logging and monitoring
- ✅ Mark sub-tasks complete [x] after finishing

### Never:
- ❌ Skip input validation or sanitization
- ❌ Hardcode secrets or API keys
- ❌ Expose internal errors to users
- ❌ Commit code without type safety
- ❌ Implement features in "Out of Scope"
- ❌ Skip authorization checks ("we'll add later")
- ❌ Use `any` type (use `unknown` if truly dynamic)
- ❌ Store passwords in plaintext
- ❌ Skip CSRF protection on mutations
- ❌ Implement without tests (for critical paths)

---

## Ready to Build!

This Constitution is the source of truth for your application. Reference it in all AI prompts:

```
@CONSTITUTION.md
@ai-framework/prompts/phase-1-planning/1.1-product-owner-prd.md

I want to build [feature]. Help me create a PRD.
```

**Next Steps:**
1. Fill in all placeholders marked with [brackets]
2. Review with your team and legal (if applicable)
3. Save as `CONSTITUTION.md` in your project root
4. Start building with the [Standard Workflow](../workflow/workflow-overview.md)

🚀 **Build something amazing!**
