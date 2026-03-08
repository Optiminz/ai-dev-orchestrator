# Constitution: AnalyticsPro SaaS Dashboard

**Type:** Client-Facing Application
**Created:** 2025-01-15
**Last Updated:** 2025-01-15

---

## Project Overview

**Name:** AnalyticsPro Dashboard

**Purpose:** A SaaS analytics platform that aggregates data from multiple sources (Google Analytics, Facebook Ads, Shopify) into a unified dashboard. Customers pay $49-299/month to track their marketing performance across channels in one place. This is a revenue-generating product serving 100+ paying customers.

---

## Core Principles

**Remember:** This is a client-facing SaaS product. Quality matters:

1. **Professional quality** - This represents our brand
2. **Secure by default** - Customer data must be protected
3. **Reliable & tested** - Downtime = lost revenue and trust
4. **Scalable** - Built for 100s of customers, designed for 1000s
5. **User-centric** - Non-technical marketers are our users

---

## Technical Stack

### Framework
```
Framework: Next.js 14 with App Router
Runtime: Node.js 20 LTS
Language: TypeScript 5+ (strict mode)
Why: Production-grade, great DX, scales well
```

### Database
```
Primary Database: PostgreSQL 15 via Supabase
ORM: Prisma (type-safe queries)
Migrations: Prisma migrations (version controlled)
Connection pooling: Supabase built-in pooler
```

### Frontend/Styling
```
Styling: Tailwind CSS 3
Component library: Shadcn/ui + Radix UI primitives
Charts: Recharts for analytics visualizations
Icons: Lucide Icons
Fonts: Inter (Google Fonts)
```

### Authentication
```
Provider: Clerk (third-party auth)
Methods: Email/password, Google OAuth, Microsoft OAuth
MFA: Optional for all users, required for admin accounts
Session management: Clerk handles it
Roles: Owner, Admin, Member, Viewer
```

### Payments
```
Provider: Stripe
Plans: Starter ($49), Pro ($149), Enterprise ($299)
Billing: Monthly, with annual discount option
Webhooks: Handle subscription events (created, canceled, past_due)
```

### API Integrations
```
Google Analytics: OAuth 2.0 with refresh tokens
Facebook Ads: Graph API with long-lived tokens
Shopify: OAuth 2.0 app
Storage: Encrypted credentials in database
Rate limiting: Respect all API limits, implement backoff
```

### File Storage
```
Storage: AWS S3
Purpose: Exported reports (CSV, PDF)
Access: Pre-signed URLs (expiring links)
Retention: 30 days
```

### Monitoring & Error Tracking
```
Error tracking: Sentry
Analytics: PostHog (self-hosted)
Uptime monitoring: UptimeRobot
Logging: Vercel logs + structured logging to Datadog
```

---

## User Context

**Who uses this:**
- Marketing managers at SMBs
- Agency clients managing multiple clients
- E-commerce store owners
- Non-technical users (comfort level: Google Sheets, Shopify admin)

**Usage patterns:**
- Daily check-ins (morning dashboard view)
- Weekly report generation
- Multi-device: Desktop (primary), tablet, mobile (viewing only)
- Browsers: Chrome, Safari, Edge

**Geographic distribution:**
- Primary: North America, Europe
- Some APAC users
- All content in English (for now)

---

## Security Requirements

### Authentication & Authorization
- All routes require authentication (except marketing pages)
- Row-level security: Users can only access their organization's data
- API keys stored encrypted at rest
- Rotate refresh tokens every 90 days
- Force password reset on suspected breach

### Data Protection
- All data encrypted at rest (database encryption)
- All data encrypted in transit (HTTPS only, TLS 1.3)
- PII handling:
  - No PII in logs or error messages
  - No PII in analytics tools
  - Customer data isolated by organization ID
- GDPR compliance:
  - Data export feature
  - Account deletion (hard delete within 30 days)
  - Cookie consent banner

### Input Validation
- All user inputs validated on client AND server
- SQL injection prevention: Use Prisma ORM only (no raw SQL)
- XSS prevention: Sanitize all user-generated content
- CSRF protection: Built into Next.js
- Rate limiting: 100 requests/minute per user

### Third-party Security
- Regular dependency audits (npm audit, Dependabot)
- Only install packages with 1M+ weekly downloads (or well-vetted)
- Webhook signature verification for Stripe
- OAuth state parameter validation

---

## Coding Standards

### File Structure
```
app/
  (marketing)/
    page.tsx
    pricing/
    about/
  (dashboard)/
    dashboard/
    integrations/
    reports/
    settings/
  api/
    webhooks/
    cron/
components/
  ui/
  marketing/
  dashboard/
  charts/
lib/
  db.ts
  auth.ts
  integrations/
  utils.ts
prisma/
  schema.prisma
  migrations/
```

### Naming Conventions
- Files: kebab-case
- Components: PascalCase
- Functions: camelCase
- Constants: UPPER_SNAKE_CASE
- Database: snake_case
- API routes: kebab-case

### Code Style
- TypeScript strict mode enabled
- ESLint + Prettier configured
- No `any` types (use `unknown` if needed)
- All functions have return type annotations
- Props interfaces defined for all components
- Zod for runtime validation

### Testing Requirements
```
Unit tests: Jest + React Testing Library
Test coverage: Minimum 70% for critical paths
Integration tests: Playwright for key user flows
API tests: Vitest for API routes
Run tests: CI/CD pipeline (GitHub Actions)

Critical paths requiring tests:
- User authentication
- Payment processing
- Data import from integrations
- Report generation
- Permission checks
```

### Comments & Documentation
- JSDoc for all exported functions
- Inline comments for complex business logic
- README for each major feature directory
- API documentation with examples

---

## Features & Scope

### What We're Building (MVP)

**Authentication & Onboarding:**
1. Sign up / sign in (email, Google, Microsoft)
2. Onboarding flow (connect first integration)
3. Team invites (max 5 users on Starter plan)

**Dashboard:**
1. Unified metrics dashboard
   - Revenue, traffic, conversion rate
   - Date range selector (7d, 30d, 90d, custom)
   - Compare to previous period
2. Channel breakdown (GA, Facebook, Shopify)
3. Top performers (products, campaigns, pages)

**Integrations:**
1. Google Analytics 4 connection
2. Facebook Ads connection
3. Shopify connection
4. Automatic daily sync (scheduled job)

**Reports:**
1. Generate custom report (select metrics, date range)
2. Export to CSV or PDF
3. Schedule weekly email report

**Settings:**
1. Team management
2. Billing (Stripe customer portal)
3. Account deletion

### What We're NOT Building Yet

- ❌ White-label / custom branding
- ❌ Additional integrations (Twitter, TikTok, etc.)
- ❌ Custom alerts/notifications
- ❌ API for customers to pull data
- ❌ Mobile apps
- ❌ Advanced analytics (forecasting, ML insights)

---

## Performance Requirements

**Target metrics:**
- Page load (Time to Interactive): < 2 seconds
- API responses: < 500ms (p95)
- Dashboard data refresh: < 3 seconds
- Uptime: 99.9% (managed by Vercel)

**Optimization strategies:**
- Server-side rendering for initial page load
- React Server Components where possible
- Incremental Static Regeneration for marketing pages
- Lazy load charts on dashboard
- Database indexes on frequently queried columns
- CDN for static assets

---

## Error Handling

### User-Facing Errors
```
Good: "We couldn't connect to your Google Analytics account. Please reconnect in Settings."
Bad: "Error 401: Unauthorized"

Always include:
- What went wrong (user-friendly)
- What the user should do next
- Support contact if needed
```

### Developer Errors
- All errors logged to Sentry with context
- Critical errors trigger PagerDuty alert
- Error boundaries around major app sections
- Graceful degradation (show cached data if API fails)

---

## Accessibility

**WCAG 2.1 AA Compliance:**
- All interactive elements keyboard accessible
- Color contrast ratio ≥ 4.5:1
- Screen reader support (ARIA labels)
- Focus indicators visible
- No flashing content

**Testing:**
- Lighthouse accessibility score ≥ 90
- Manual testing with VoiceOver / NVDA

---

## Documentation

**Required documentation:**
1. README (setup, deployment, architecture overview)
2. API documentation (Swagger/OpenAPI for all endpoints)
3. Database schema docs (auto-generated from Prisma)
4. User help docs (help.analyticspro.com - Notion-based)
5. Incident runbook (how to handle common issues)

---

## Deployment

**Platform:** Vercel (Production + Preview)

**Environments:**
- Development (local)
- Preview (per-PR automatic deployments)
- Staging (staging.analyticspro.com)
- Production (app.analyticspro.com)

**CI/CD Pipeline:**
1. Pull request → Run tests + linting
2. Merge to main → Deploy to staging
3. Manual promote to production (after smoke tests)

**Environment Variables:**
```
DATABASE_URL (Supabase connection string)
CLERK_SECRET_KEY
STRIPE_SECRET_KEY
STRIPE_WEBHOOK_SECRET
GOOGLE_CLIENT_ID / GOOGLE_CLIENT_SECRET
FACEBOOK_APP_ID / FACEBOOK_APP_SECRET
SHOPIFY_CLIENT_ID / SHOPIFY_CLIENT_SECRET
SENTRY_DSN
POSTHOST_API_KEY
AWS_S3_BUCKET / AWS_ACCESS_KEY / AWS_SECRET_KEY
```

---

## Database Design Principles

- Normalize to 3NF (avoid data duplication)
- Use UUIDs for primary keys (not auto-increment)
- Timestamps: `created_at`, `updated_at` on all tables
- Soft deletes: `deleted_at` column (don't hard delete user data)
- Foreign keys with `ON DELETE CASCADE` where appropriate
- Indexes on all foreign keys and frequently queried columns

---

## API Design Principles

**RESTful conventions:**
- GET /api/organizations/:id
- POST /api/organizations
- PUT /api/organizations/:id
- DELETE /api/organizations/:id

**Response format:**
```json
{
  "data": { ... },
  "error": null,
  "meta": {
    "page": 1,
    "total": 100
  }
}
```

**Error format:**
```json
{
  "data": null,
  "error": {
    "code": "INTEGRATION_AUTH_FAILED",
    "message": "Google Analytics connection expired",
    "details": {}
  }
}
```

---

## AI Instructions

When generating code for this project:

1. **Production-grade quality** - This is NOT a prototype
2. **Type safety** - All code fully typed, no `any`
3. **Error handling** - Every API call wrapped in try/catch
4. **Validation** - Use Zod for all input validation
5. **Security first** - Never trust user input
6. **Test coverage** - Include tests for critical paths
7. **Accessibility** - Semantic HTML, ARIA labels
8. **Performance** - Code splitting, lazy loading where appropriate
9. **Comments** - Document complex logic and business rules
10. **Follow patterns** - Match existing code style and architecture

---

**This is a PAYING customer product. Quality, security, and reliability are non-negotiable.**
