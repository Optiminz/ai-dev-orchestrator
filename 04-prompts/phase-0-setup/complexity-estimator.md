# Prompt: Feature Complexity Estimator

**Persona:** Project Manager + Solutions Architect
**Phase:** 0 - Setup (before planning)
**Purpose:** Analyze a feature idea and recommend the appropriate workflow

---

## When to Use This Prompt

✅ **Use when:**
- You have a feature idea but aren't sure how to approach it
- You want guidance on whether to use Quick Start, Standard, or Full workflow
- You're unsure about the scope and complexity
- You need help deciding what workflow fits your experience level

❌ **Don't use when:**
- You already know which workflow to use
- You've already created a PRD
- The feature is obviously simple or obviously complex

---

## The Prompt Template

```markdown
You are a Project Manager and Solutions Architect. I need you to analyze a feature idea and recommend the best development workflow from the ai-dev-orchestrator framework.

## Feature Description
[Describe the feature you want to build - be as detailed or as vague as you are right now]

## Context
- **Project Type:** [Internal tool / Client app / AI agent / Other]
- **My Experience:** [First feature with AI / Built 2-3 features / Experienced with AI dev]
- **Users:** [Approximately how many users]
- **Timeline:** [When do you need this by?]
- **Tech Stack:** [What you're building with, if you know]

## Analysis Required

Analyze this feature across these dimensions:

### 1. Technical Complexity
- How many systems/integrations?
- Database design complexity?
- API complexity?
- Frontend complexity (if applicable)?
- Any novel/untested technical challenges?

### 2. Scope
- How many user stories (rough estimate)?
- How many distinct features/capabilities?
- Is this focused or broad?

### 3. Risk Level
- Security sensitive?
- Handles payments or PII?
- Critical to business operations?
- High user visibility/impact?

### 4. User Experience Needs
- Basic functional UI okay?
- Needs professional polish?
- Complex interactions?
- Mobile important?

### 5. Time Sensitivity
- Prototype/MVP okay?
- Needs to be production-ready?
- Room for iteration?

## Recommendation Format

Based on your analysis, recommend ONE of these workflows:

### Option A: Quick Start Workflow
**Recommended if:**
- Low to medium complexity
- Internal use or low-risk
- Fast iteration preferred
- Basic quality is acceptable
- 1-5 user stories
- Can be built in 2-4 hours

**Workflow:**
1. Use `/quick-start/simple-workflow.md` (combined PRD + planning)
2. Use `/quick-start/process-task-list.md` (interactive task generation)
3. Implement iteratively (one sub-task at a time)

**Skip:** Tech specs, formal reviews (use manual testing)

---

### Option B: Standard Workflow
**Recommended if:**
- Medium complexity
- Client-facing or medium-risk
- Needs architectural planning
- Professional quality required
- 5-10 user stories
- Can be built in 1-3 days

**Workflow:**
1. Create PRD: `/prompts/phase-1-planning/1.1-product-owner-prd.md`
2. Create Tech Spec: `/prompts/phase-1-planning/1.2-architect-tech-spec.md`
3. Generate Tasks: `/prompts/phase-2-implementation/2.1-generate-task-list.md`
4. Implement: `/prompts/phase-2-implementation/2.2-iterative-implementation.md`
5. Review: `/prompts/phase-3-review/3.1-qa-comprehensive-review.md`

**Optional:** Database design prompt (if complex schema), API design prompt

---

### Option C: Full Framework Workflow
**Recommended if:**
- High complexity
- Production-critical or high-risk
- Handles sensitive data (payments, PII, health data)
- Needs comprehensive testing and documentation
- 10+ user stories
- Built over multiple days/weeks
- Requires audit trail and security reviews

**Workflow:**
1. **Planning (Phase 1):**
   - PRD: `1.1-product-owner-prd.md`
   - Tech Spec: `1.2-architect-tech-spec.md`
   - Database Design: `1.3-architect-database-design.md` (if applicable)
   - API Design: `1.4-architect-api-design.md` (if applicable)

2. **Implementation (Phase 2):**
   - Task Generation: `2.1-generate-task-list.md`
   - Iterative Implementation: `2.2-iterative-implementation.md`

3. **Review (Phase 3):**
   - QA Review: `3.1-qa-comprehensive-review.md`
   - Security Review: `3.2-security-focused-review.md`
   - Performance Review: `3.3-performance-review.md` (if applicable)
   - Code Quality Review: `3.4-code-quality-review.md`

4. **Documentation (Phase 4):**
   - README: `4.1-readme-generator.md`
   - API Docs: `4.2-api-documentation.md` (if applicable)

**Use:** All specialized personas, comprehensive reviews

---

## Your Specific Recommendation

**Recommended Workflow:** [Quick Start / Standard / Full Framework]

**Reasoning:**
- Technical Complexity: [Low / Medium / High] - [Why?]
- Scope: [X user stories, Y features]
- Risk Level: [Low / Medium / High] - [Why?]
- UX Needs: [Basic / Professional / Advanced]
- Time Available: [X hours/days]

**Specific Considerations for This Feature:**
[List 2-3 specific things to pay attention to based on the feature description]

**Suggested First Steps:**
1. [First step]
2. [Second step]
3. [Third step]

**Potential Challenges:**
- [Challenge 1 and how to mitigate]
- [Challenge 2 and how to mitigate]

**Estimated Timeline:**
- Planning: [X hours]
- Implementation: [Y hours/days]
- Review/Testing: [Z hours]
- Total: [Total time]

---

## Questions to Clarify (if needed)

If the feature description is too vague to make a recommendation, ask these clarifying questions:

1. **Scope Questions:**
   - What's the core problem this solves?
   - Who are the users and how many?
   - What does "done" look like (minimum viable)?

2. **Technical Questions:**
   - Do you already have a database schema?
   - Are there external integrations (APIs, services)?
   - Is this frontend, backend, or both?

3. **Context Questions:**
   - What's your technical background?
   - Have you built similar features before?
   - What's the acceptable quality level (MVP vs. production)?

4. **Risk Questions:**
   - Does this handle sensitive data (PII, payments, health)?
   - Is this user-facing or internal?
   - What happens if it fails or has bugs?
```

---

## How to Use This Prompt

### Step 1: Gather Your Feature Idea

Write down:
- What you want to build (even if vague)
- Who will use it
- Roughly when you need it
- Your experience level with AI development

### Step 2: Use the Prompt

Paste the prompt template above to your AI assistant (Cursor, Claude Code, ChatGPT, etc.) and fill in your feature description and context.

### Step 3: Review the Recommendation

The AI will recommend Quick Start, Standard, or Full Framework workflow based on:
- Complexity
- Risk
- Your experience
- Timeline

### Step 4: Follow the Recommended Workflow

Once you have a recommendation, use the prompts from that workflow:

**If Quick Start:** Go to `/quick-start/README.md`
**If Standard:** Go to `/workflow/workflow-overview.md`
**If Full Framework:** Read the main `README.md` completely

---

## Example Usage

### Example 1: Simple Internal Tool

**Input:**
```
Feature: A simple expense tracker for our 5-person team where we can log expenses, categorize them, and see monthly totals.

Context:
- Project: Internal tool
- Experience: First feature with AI
- Users: 5 people (our team)
- Timeline: Need it this week
- Tech Stack: Not sure, maybe Next.js?
```

**AI Analysis:**
```
Technical Complexity: LOW
- Simple CRUD operations
- No complex integrations
- Basic database schema (expenses table)
- Simple UI (forms, tables)

Scope: SMALL
- 3-4 user stories (create expense, view expenses, categorize, monthly summary)
- Single focused feature

Risk: LOW
- Internal use only
- No sensitive data (just expense amounts)
- Low user impact if bugs exist

UX Needs: BASIC
- Functional UI is fine
- No need for polish

Recommended Workflow: **QUICK START**

Estimated Timeline:
- Planning: 30 min (simple PRD)
- Task Generation: 30 min
- Implementation: 2-3 hours
- Testing: 30 min (manual)
Total: 4-5 hours

First Steps:
1. Use `/quick-start/simple-workflow.md` to create PRD
2. Choose tech stack (recommend: Next.js + Supabase for beginners)
3. Generate task list with interactive mode
4. Start implementing first task
```

---

### Example 2: Client-Facing SaaS Feature

**Input:**
```
Feature: A dashboard where our customers can see real-time analytics about their e-commerce store - sales, conversion rates, top products, etc.

Context:
- Project: Client SaaS application
- Experience: Built 3-4 features with AI
- Users: 500+ customers
- Timeline: Need it in 2 weeks
- Tech Stack: React, Node.js, PostgreSQL
```

**AI Analysis:**
```
Technical Complexity: MEDIUM-HIGH
- Real-time data processing
- Complex queries (aggregations, time-series)
- Performance critical (must be fast)
- Multiple data sources (orders, products, customers)

Scope: MEDIUM
- 7-8 user stories (view sales, filter by date, compare periods, export data, etc.)
- Multiple interconnected features

Risk: MEDIUM-HIGH
- Customer-facing (represents your brand)
- Performance issues highly visible
- Data accuracy critical (business decisions based on this)

UX Needs: PROFESSIONAL
- Must be polished and intuitive
- Needs to handle large datasets gracefully
- Mobile-responsive important

Recommended Workflow: **STANDARD** (leaning toward FULL if security/performance critical)

Estimated Timeline:
- PRD: 1-2 hours
- Tech Spec: 2-3 hours (architecture decisions important)
- Task Generation: 1 hour
- Implementation: 5-8 days
- QA Review: 2-3 hours
- Performance testing: 2-3 hours
Total: 7-10 days

First Steps:
1. Create comprehensive PRD (use `1.1-product-owner-prd.md`)
2. Create tech spec focusing on:
   - Data aggregation strategy (real-time vs. batch)
   - Caching approach
   - Database query optimization
3. Consider database design prompt (complex schema)
4. Generate detailed task list
5. Implement with rigorous testing

Specific Considerations:
- Performance: Use database indexes, consider caching (Redis)
- Security: Ensure proper data isolation (customers can't see each other's data)
- Scalability: Design queries to handle 100k+ records
- Consider adding API design prompt if exposing this as an API

Potential Challenges:
- Real-time updates: May need WebSockets or polling strategy
- Query performance: Large datasets require optimization
- Data accuracy: Ensure calculations match business logic exactly
```

---

### Example 3: Payment Integration

**Input:**
```
Feature: Integrate Stripe payments so users can subscribe to our Pro plan ($49/month).

Context:
- Project: Client SaaS app
- Experience: Comfortable with AI dev
- Users: Growing from 100 to 1000 users
- Timeline: 1 week
- Tech Stack: Next.js, Supabase, Vercel
```

**AI Analysis:**
```
Technical Complexity: MEDIUM
- Stripe integration (well-documented)
- Webhook handling
- Subscription state management
- But: Financial transactions = high stakes

Scope: MEDIUM
- 6-7 user stories (subscribe, cancel, update payment, handle failures, etc.)

Risk: HIGH ⚠️
- Handles payments (money involved)
- Security critical (PCI compliance)
- Edge cases matter (failed payments, cancellations, refunds)
- Legal implications (terms of service, refund policy)

UX Needs: PROFESSIONAL
- Must be trustworthy (users entering credit cards)
- Error handling must be clear
- Confirmation emails required

Recommended Workflow: **FULL FRAMEWORK**

Reasoning:
Despite medium technical complexity, this feature is HIGH RISK due to:
- Financial transactions (errors cost money)
- Security requirements (PCI compliance via Stripe)
- Legal requirements (terms, refunds, cancellations)
- Edge cases are critical (failed payment = lost revenue)

Estimated Timeline:
- PRD: 2 hours (include all edge cases)
- Tech Spec: 3-4 hours (architecture + security)
- API Design: 2 hours (Stripe webhooks, your API)
- Task Generation: 1-2 hours (comprehensive task list)
- Implementation: 3-4 days
- QA Review: 3-4 hours (test all paths)
- Security Review: 2-3 hours (PCI, data handling)
- Manual Testing: 2-3 hours (Stripe test mode, all scenarios)
Total: 5-7 days

First Steps:
1. Create comprehensive PRD including:
   - All user stories (happy path + edge cases)
   - Acceptance criteria (what happens when payment fails?)
   - Out of scope (what you won't handle initially)

2. Create detailed tech spec including:
   - Stripe integration architecture
   - Webhook handling (idempotency!)
   - Database schema for subscriptions
   - Error handling strategy
   - Security considerations (don't store cards!)

3. Use API design prompt for Stripe webhook endpoints

4. Implement with:
   - Unit tests (business logic)
   - Integration tests (Stripe test mode)
   - Security review (before launch)

5. Test extensively in Stripe test mode:
   - Successful subscription
   - Failed payment
   - Subscription cancellation
   - Webhook retries
   - Refunds

Specific Considerations:
- Use Stripe's official SDK (don't build from scratch)
- Webhook idempotency (Stripe may send duplicates)
- Handle all webhook events (subscription.created, invoice.payment_failed, etc.)
- Don't store credit card data (let Stripe handle it)
- Test edge cases thoroughly (expired card, insufficient funds, etc.)

Potential Challenges:
- Webhook reliability: Network failures can cause missed events
  - Mitigation: Implement retries, reconciliation jobs
- Subscription state sync: Your DB vs. Stripe as source of truth
  - Mitigation: Use Stripe as source of truth, sync regularly
- Testing: Hard to test some scenarios
  - Mitigation: Use Stripe test mode cards, test all failure modes
```

---

## Decision Matrix

Use this matrix if you're on the fence between workflows:

| Factor | Quick Start | Standard | Full Framework |
|--------|-------------|----------|----------------|
| **User Stories** | 1-5 | 5-10 | 10+ |
| **Timeline** | Hours | 1-3 days | Days/Weeks |
| **Users** | Internal team | Customers | Many customers |
| **Risk** | Low | Medium | High |
| **Data Sensitivity** | None/Low | Medium | High (PII, payments, health) |
| **Quality Needs** | Functional | Professional | Production-grade |
| **Your Experience** | Beginner | Intermediate | Advanced OR high-stakes project |
| **Testing** | Manual | Manual + basic automated | Comprehensive automated |
| **Documentation** | README only | README + some docs | Comprehensive docs |
| **Reviews** | None | QA review | QA + Security + Performance |

**General Rule:**
- If most factors point to Quick Start → Use Quick Start
- If most factors point to Full Framework → Use Full Framework
- If mixed → Use Standard (it's the balanced middle ground)

---

## Next Steps After Recommendation

Once you receive a workflow recommendation:

### If Quick Start:
1. Go to `/quick-start/README.md`
2. Read the guide (5 minutes)
3. Use `simple-workflow.md` to create PRD
4. Start building!

### If Standard:
1. Go to `/workflow/workflow-overview.md`
2. Understand the 5-step process
3. Start with Phase 1: Create PRD (`1.1-product-owner-prd.md`)
4. Follow the workflow sequentially

### If Full Framework:
1. Read the main `README.md` completely
2. Study all phases and specialized prompts
3. Plan your approach (which prompts you'll use)
4. Start with Phase 1 prompts
5. Be thorough - this is high-stakes

---

## Related Resources

- [Quick Start Guide](../../quick-start/README.md)
- [Workflow Overview](../../workflow/workflow-overview.md)
- [Prompt Selection Guide](../../workflow/prompt-selection-guide.md)
- [Main README](../../README.md)

---

**Ready to analyze your feature?** Paste the prompt template to your AI assistant and get a personalized workflow recommendation! 🚀
