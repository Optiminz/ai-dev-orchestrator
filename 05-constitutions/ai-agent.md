# Constitution: [Your AI Agent/Bot Name]

**Type:** AI Agent / Bot / API Service
**Created:** [Date]
**Last Updated:** [Date]

---

## Project Overview

**Name:** [Your Agent/Bot Name]

**Purpose:** [What does this agent do? What problem does it solve?]

**Integration Points:** [Where does this agent run? Slack, Discord, API, Webhook, etc.]

**Example:**
```
Purpose: A Slack bot that helps customer support teams quickly look up
customer information, create tickets, and answer common questions using AI.

Integration: Slack (slash commands + mentions)
Triggers: /customer [email], @supportbot [question]
```

---

## Core Principles

**This is an agent/bot. These principles guide all decisions:**

1. **API-First Design** - Everything is an API endpoint or webhook handler
2. **Reliability is Critical** - Agents must handle failures gracefully
3. **Rate Limits Matter** - Respect external API limits and quotas
4. **Async by Default** - Use queues and background jobs
5. **Comprehensive Logging** - Debug issues without user reports
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

### Runtime & Framework
```
Runtime: [Node.js / Python / Go / etc.]
Framework: [Express / FastAPI / Hono / etc.]
Language: [TypeScript / Python / etc.]
```

**Example:**
```
Runtime: Node.js 20 (LTS)
Framework: Hono (edge-native, fast)
Language: TypeScript (strict mode enabled)
File extensions: .ts for all files (no JSX/TSX for agents)
Type imports: import type { ... } for type-only imports
Deployment: Cloudflare Workers (edge, low latency)
```

### AI/LLM Integration
```
LLM Provider: [OpenAI / Anthropic / Together / etc.]
Model: [GPT-4 / Claude / etc.]
Fallback: [What happens if LLM fails?]
Context Management: [How do you handle conversation context?]
```

**Example:**
```
Primary LLM: Anthropic Claude Sonnet 4.5
Fallback: OpenAI GPT-4 (if Claude unavailable)
Context: Store last 10 messages in Redis (per conversation)
Prompt Caching: Use Anthropic prompt caching for system prompts
Streaming: Yes (for long responses)
```

### Database & Storage
```
Primary Database: [PostgreSQL / MongoDB / Redis / etc.]
Caching: [Redis / In-memory / etc.]
Vector Database: [Pinecone / Weaviate / Supabase Vector / etc.]
File Storage: [S3 / R2 / etc.]
```

**Example:**
```
Primary: PostgreSQL (Supabase) for structured data
Caching: Redis (Upstash) for:
  - Conversation history (TTL: 24h)
  - Rate limit counters
  - LLM response cache (common queries)

Vector DB: Supabase Vector (pgvector) for:
  - Knowledge base embeddings
  - Semantic search on support docs

File Storage: Cloudflare R2 for uploaded files
```

### Integrations
```
Platform: [Slack / Discord / Telegram / WhatsApp / etc.]
External APIs: [List APIs you'll call]
Webhooks: [List webhooks you'll receive]
```

**Example:**
```
Platform: Slack (Bolt SDK)
- Commands: /customer, /ticket, /help
- Events: app_mention, message (in DM)
- Interactive: Button clicks, modal submissions

External APIs:
- Stripe API (customer lookup)
- Zendesk API (ticket creation)
- Internal customer API (user data)

Webhooks:
- Stripe webhooks (subscription events)
- Zendesk webhooks (ticket updates)
```

---

## Agent Behavior & Capabilities

### Core Functions
```
What can this agent do?
1. [Function 1]
2. [Function 2]
3. [Function 3]
```

**Example:**
```
Capabilities:
1. Customer Lookup
   - Input: Email or customer ID
   - Output: Customer details, subscription status, recent activity
   - Source: Stripe API + internal database

2. Create Support Ticket
   - Input: Issue description
   - Output: Ticket number and link
   - Creates ticket in Zendesk, notifies customer

3. Answer Questions
   - Input: Natural language question
   - Output: AI-generated answer from knowledge base
   - Uses RAG (retrieval-augmented generation)

4. Escalate to Human
   - Input: "I need a human" or complex query
   - Output: Connects to on-call support agent
```

### Conversation Flow
```
How does the agent handle conversations?
- State management: [Stateless / Stateful]
- Multi-turn conversations: [Yes / No]
- Context retention: [Duration]
```

**Example:**
```
Flow:
1. User sends message (slash command or @mention)
2. Bot acknowledges immediately ("Looking that up...")
3. Process request (call APIs, query LLM)
4. Respond with results
5. Offer follow-up actions (buttons for common next steps)

State: Stateful for 30 minutes
- Store conversation context in Redis
- After 30min idle, clear context (start fresh)

Multi-turn: Yes
- "Show me customer details for john@example.com"
- "What's their subscription status?"
- "Create a ticket for billing issue"
(Bot remembers we're talking about john@example.com)
```

### Personality & Tone
```
How should the agent communicate?
- Tone: [Professional / Friendly / Casual]
- Emoji usage: [Yes / No / Sparingly]
- Language: [English / Multi-language]
```

**Example:**
```
Tone: Friendly but professional (customer support context)
Emoji: Sparingly (✅ for success, ⚠️ for warnings, 🎫 for tickets)
Language: English (US) only for v1, Spanish for v2

Example responses:
- Success: "✅ Found customer: John Doe (Tier: Pro, Status: Active)"
- Error: "⚠️ Couldn't find a customer with that email. Double-check the spelling?"
- Help: "I can help you with: customer lookup, creating tickets, or answering questions. What do you need?"
```

---

## Type Sharing (Full-Stack TypeScript)

**Single Source of Truth:**
- All data types defined ONCE in `shared/schema.ts` (or `types/`)
- Agent code imports types from shared location
- API request/response types never use `any`
- Webhook payloads typed with schema types

**Pattern:**
```typescript
// shared/schema.ts - AUTHORITATIVE
export type WebhookPayload = { event: string; data: unknown };
export type User = { id: number; name: string; email: string };

// Agent - imports from shared
import type { WebhookPayload, User } from './shared/schema';

// External API types
import type { SlackEvent } from '@slack/bolt';
```

**Prohibited:**
- ❌ Using `any` for API responses or webhook payloads
- ❌ Redefining types that exist in shared schema
- ❌ Manual type guards when schema types exist

---

## API Design

### Endpoints
```
List all API endpoints:
- POST /api/webhook/slack - Handle Slack events
- POST /api/webhook/stripe - Handle Stripe webhooks
- GET /api/health - Health check
- POST /api/chat - Chat endpoint (if public API)
```

**Example:**
```
Endpoints:
POST /webhook/slack
- Purpose: Handle all Slack events (commands, mentions, interactions)
- Auth: Slack signature verification
- Rate limit: None (Slack handles this)

POST /webhook/stripe
- Purpose: Handle Stripe webhook events
- Auth: Stripe signature verification
- Events: customer.subscription.updated, invoice.payment_failed

GET /health
- Purpose: Health check for monitoring
- Returns: { status: "ok", uptime: X, version: "1.2.3" }

POST /api/chat (future - public API)
- Purpose: Chat with the bot via API
- Auth: API key (Bearer token)
- Rate limit: 100 req/hour per API key
```

### Authentication
```
How are API requests authenticated?
- Webhooks: [Signature verification]
- Public API: [API keys / OAuth / JWT]
- Internal: [Service-to-service auth]
```

**Example:**
```
Webhooks:
- Slack: Verify signing secret (req.headers['x-slack-signature'])
- Stripe: Verify webhook signature (stripe.webhooks.constructEvent)

Public API (future):
- API Keys: Bearer tokens stored hashed in database
- Scope: Per-key permissions (read, write, admin)
- Rotation: Keys expire after 90 days

Internal:
- Service tokens: Shared secret in environment variables
- mTLS for service-to-service (if deployed in VPC)
```

### Rate Limiting
```
How do you prevent abuse?
- Per user: [X requests per Y]
- Per API key: [X requests per Y]
- Global: [X requests per Y]
- Strategy: [Token bucket / Fixed window / Sliding window]
```

**Example:**
```
Rate Limits:
Per Slack user: 30 requests/minute (prevents spam)
Per API key: 100 requests/hour (for public API)
Global: 10,000 requests/hour (total across all users)

Strategy: Sliding window (Redis-backed)
Storage: Redis with TTL
Response: 429 Too Many Requests with Retry-After header

Exemptions:
- Internal service accounts: No rate limit
- Enterprise customers: Custom limits (configurable)
```

---

## Error Handling

### Error Categories
```
How do you handle different error types?
1. User Errors (4xx) - [User did something wrong]
2. External API Errors - [Third-party service failed]
3. Internal Errors (5xx) - [Our code failed]
4. LLM Errors - [AI model failed or returned bad output]
```

**Example:**
```
1. User Errors (400-level)
   - Invalid input: "Email format invalid. Try: user@example.com"
   - Not found: "No customer found with that email"
   - Unauthorized: "You don't have permission for this command"
   Response: Friendly error message, no retry

2. External API Errors
   - Stripe timeout: "Stripe is slow right now. Retrying..."
   - Zendesk 5xx: "Ticket system unavailable. Try again in a minute?"
   Response: Retry with exponential backoff (3 attempts)

3. Internal Errors
   - Database down: "Something went wrong on our end. We've been notified."
   - Unhandled exception: Same as above
   Response: Log to Sentry, alert on-call, apologize to user

4. LLM Errors
   - Rate limit hit: Fall back to cached responses or simpler model
   - Invalid response: "I'm having trouble understanding that. Can you rephrase?"
   - Timeout: "This is taking too long. Let me get a human to help."
   Response: Graceful degradation, never expose raw LLM errors
```

### Retry Logic
```
When to retry:
- Transient errors: [Network timeouts, 503 from external API]
- Non-transient: [400 Bad Request, 404 Not Found]

Retry strategy:
- Max attempts: [3]
- Backoff: [Exponential - 1s, 2s, 4s]
- Circuit breaker: [Open after X failures]
```

**Example:**
```
Retry Policy:
Max attempts: 3
Backoff: Exponential (1s, 2s, 4s)
Jitter: +/- 500ms (prevent thundering herd)

Retryable:
- 5xx from external APIs
- Network timeouts
- Rate limit errors (429) - wait for Retry-After

Non-retryable:
- 400 Bad Request (our fault, fix the request)
- 401/403 Auth errors (credentials wrong, don't retry)
- 404 Not Found (resource doesn't exist)

Circuit Breaker:
- Open circuit after 10 consecutive failures
- Half-open after 60 seconds (try one request)
- Close if successful, else extend timeout exponentially
```

### Fallback Strategies
```
What happens when things fail?
- LLM unavailable: [Fallback model or canned responses]
- External API down: [Cached data or degrade gracefully]
- Database down: [Read-only mode or fail completely]
```

**Example:**
```
LLM Fallback:
- Primary: Claude Sonnet → Fallback: GPT-4 → Last resort: Rule-based responses
- Cache common queries (What are your hours? How do I contact support?)

External API:
- Stripe down: Show cached customer data (warn: "Info may be stale")
- Zendesk down: Store ticket request, create when service recovers

Database:
- Read replicas: Failover to replica for reads
- Write failure: Queue write operations, process when recovered
- Total failure: Return 503, don't pretend it works
```

---

## Monitoring & Observability

### Logging
```
What to log:
- All requests/responses
- Errors and exceptions
- User actions (audit trail)
- LLM prompts and responses
- External API calls
```

**Example:**
```
Structured Logging (JSON):
{
  "timestamp": "2025-01-15T10:30:00Z",
  "level": "info",
  "event": "slack_command_received",
  "user_id": "U12345",
  "channel_id": "C67890",
  "command": "/customer",
  "args": "john@example.com",
  "request_id": "req_abc123"
}

Log Levels:
- DEBUG: LLM prompts/responses (dev only)
- INFO: All user interactions, API calls
- WARN: Retries, degraded performance, fallbacks
- ERROR: Failures, exceptions

PII Handling:
- Scrub sensitive data (emails → email@***, names → [NAME])
- Store full data only in encrypted audit log
- Never log passwords, API keys, credit cards

Tool: Datadog (structured logs, searchable)
Retention: 30 days
```

### Metrics
```
What to measure:
- Request volume and latency
- Error rates (by type)
- LLM usage (tokens, cost)
- External API latency
- Queue depth (background jobs)
```

**Example:**
```
Key Metrics:
1. Request volume
   - slack_commands_total (counter, by command type)
   - api_requests_total (counter, by endpoint)

2. Latency
   - request_duration_seconds (histogram)
   - llm_response_time_seconds (histogram)
   - external_api_latency_seconds (histogram, by service)

3. Errors
   - errors_total (counter, by type: user, external, internal)
   - retry_attempts_total (counter, by service)

4. LLM Metrics
   - llm_tokens_used_total (counter, by model)
   - llm_cost_usd (gauge, estimated)
   - llm_cache_hit_rate (gauge)

5. Business Metrics
   - customers_looked_up_total (counter)
   - tickets_created_total (counter)
   - questions_answered_total (counter)
   - escalations_to_human_total (counter)

Tool: Prometheus metrics → Grafana dashboards
```

### Alerts
```
When to alert:
- Error rate > X%
- Latency > Xms
- External API down
- LLM budget exceeded
```

**Example:**
```
Critical Alerts (PagerDuty):
- Error rate > 5% for 5 minutes
- All requests failing for 2 minutes
- Database unreachable
- LLM budget > 80% of monthly limit

Warning Alerts (Slack #alerts):
- Error rate > 1% for 10 minutes
- P95 latency > 2 seconds
- External API degraded (retries increasing)
- Queue depth > 1000 jobs

Info Alerts (Slack #bot-activity):
- Hourly usage summary
- Daily cost report
- New user activations
```

---

## Security

### API Security
```
- Input validation: [Zod / Joi / etc.]
- SQL injection: [ORM / Parameterized queries]
- Command injection: [No shell execution / sanitize inputs]
- Rate limiting: [See above]
```

**Example:**
```
Input Validation:
- All inputs validated with Zod schemas
- Example:
  const SlackCommandSchema = z.object({
    command: z.string(),
    text: z.string().max(500),
    user_id: z.string().regex(/^U[A-Z0-9]+$/),
    channel_id: z.string().regex(/^C[A-Z0-9]+$/)
  });

SQL Injection:
- Never use string concatenation for SQL
- Always use Prisma ORM or parameterized queries
- Example:
  // Safe
  await db.customer.findUnique({ where: { email } });
  // Unsafe - NEVER DO THIS
  await db.$queryRaw(`SELECT * FROM customers WHERE email = '${email}'`);

Command Injection:
- Never execute shell commands with user input
- If absolutely necessary, use strict allowlists
- Example:
  // NEVER
  exec(`convert ${userFilename} output.png`);
  // BETTER
  if (!/^[a-zA-Z0-9_-]+\.jpg$/.test(userFilename)) throw error;
  exec(['convert', safeFilename, 'output.png']);
```

### Secrets Management
```
How are secrets stored?
- Development: [.env.local file, gitignored]
- Production: [Environment variables / Secrets manager]
- Rotation: [Manual / Automated]
```

**Example:**
```
Secrets:
- Slack tokens, API keys, database URLs
- Never in code, never in Git

Development:
- .env.local file (added to .gitignore)
- Shared via 1Password team vault

Production:
- Cloudflare Workers secrets (encrypted)
- Accessed via env.SECRET_NAME
- Rotated quarterly (manual for now, automated in future)

Validation:
- CI checks for accidentally committed secrets (gitleaks)
- Pre-commit hook scans for common secret patterns
```

### Audit Logging
```
What actions to audit:
- Admin actions (config changes)
- Data access (who looked up what customer)
- Ticket creation
- Escalations
```

**Example:**
```
Audit Log (separate table, append-only):
{
  "timestamp": "2025-01-15T10:30:00Z",
  "user_id": "U12345",
  "action": "customer_lookup",
  "resource": "customer:cus_abc123",
  "metadata": {
    "customer_email": "john@example.com",
    "subscription_status": "active"
  },
  "ip_address": "192.0.2.1",
  "user_agent": "Slack/1.2.3"
}

Retention: 1 year
Access: Admin only
Compliance: GDPR-compliant (users can request their audit logs)
```

---

## Scalability

### Asynchronous Processing
```
What tasks run async?
- Long-running operations (> 2 seconds)
- External API calls (when possible)
- Batch operations
```

**Example:**
```
Queue: BullMQ (Redis-backed)
Workers: 2 workers (scale to 10 if queue depth > 100)

Async Tasks:
1. Ticket creation
   - User sends /ticket command
   - Bot responds: "Creating ticket..." (immediate)
   - Job: Create ticket in Zendesk (background)
   - Update Slack thread when done (1-5 seconds later)

2. Knowledge base indexing
   - When docs updated
   - Job: Generate embeddings, update vector DB
   - Can take 30 seconds for large doc

3. Daily summaries
   - Cron: Every day at 9am
   - Job: Generate summary of previous day's activity
   - Post to #bot-summary channel

Retry: Failed jobs retry 3x with exponential backoff
DLQ: After 3 failures, move to dead letter queue for manual review
```

### Caching Strategy
```
What to cache:
- LLM responses (common queries)
- External API responses (if data doesn't change often)
- Database queries (hot data)
```

**Example:**
```
Cache (Redis):
1. LLM Responses
   - Key: hash(prompt + context)
   - TTL: 1 hour
   - Invalidate: When knowledge base updated
   - Hit rate target: >50%

2. Customer Data
   - Key: customer:email:john@example.com
   - TTL: 5 minutes
   - Invalidate: On update (via webhook)
   - Reduces Stripe API calls by 80%

3. Conversation Context
   - Key: conversation:U12345:C67890
   - TTL: 30 minutes
   - Value: Last 10 messages + metadata

Cache-aside pattern: Check cache → Miss → Fetch → Cache → Return
```

### Horizontal Scaling
```
Can you run multiple instances?
- Stateless: [Yes / No]
- Shared state: [Redis / Database]
- Load balancer: [Cloudflare / NGINX / etc.]
```

**Example:**
```
Scaling:
- Stateless: Yes (all state in Redis/PostgreSQL)
- Instances: Start with 2, auto-scale to 10 based on CPU/memory
- Load balancer: Cloudflare Workers (global edge network)

Concurrency:
- Each worker handles 100 concurrent requests
- Queue workers: 2-10 based on queue depth
- Database: Connection pooling (max 100 connections)

Bottlenecks:
- LLM rate limits (Claude: 100k tokens/min)
- External APIs (Stripe, Zendesk rate limits)
- Database write throughput (if > 10k req/min)

Mitigation:
- LLM: Queue requests, cache responses
- External APIs: Respect rate limits, backoff
- Database: Read replicas, sharding (if needed at scale)
```

---

## Testing Strategy

### Unit Tests
```
Framework: [Vitest / Jest / Pytest]
Coverage: [X%]
What to test:
- Parsing and validation logic
- Business logic (no external calls)
- Error handling
```

**Coverage Thresholds:**
| Area | Minimum | Target |
|------|---------|--------|
| Business logic | 70% | 85% |
| Utility functions | 80% | 95% |
| API endpoints | 70% | 80% |
| Webhook handlers | 60% | 75% |

**"Adequate testing" checklist:**
- [ ] Happy path tested with realistic data
- [ ] Error cases tested (invalid input, network failures)
- [ ] Edge cases for user input (empty, too long, special chars)
- [ ] API contract validated (request/response shapes)
- [ ] Retry logic tested (exponential backoff)
- [ ] Rate limiting tested

**Testing philosophy:**
- Test behavior, not implementation
- Mock external services (LLMs, APIs)
- Test error handling paths thoroughly
- Verify idempotency for retried operations

**Example:**
```
Framework: Vitest
Coverage: 70% (focus on critical paths)

Test Cases:
- Input validation (valid/invalid emails, commands)
- Response formatting (Slack message blocks)
- Error messages (friendly, actionable)
- Retry logic (exponential backoff)
- Cache key generation (consistent hashing)

Mock: All external services (Slack, LLM, Stripe, database)
```

### Integration Tests
```
What to test:
- End-to-end flows (webhook → processing → response)
- External API integrations
- Database operations
```

**Example:**
```
Framework: Vitest + Testcontainers (real PostgreSQL + Redis)

Test Flows:
1. Slack Command → Customer Lookup → Response
   - Mock Stripe API (return test customer data)
   - Verify correct data formatted in response
   - Check audit log entry created

2. Webhook Received → Job Queued → Processed
   - Send test webhook
   - Verify job created in queue
   - Process job, verify side effects

3. LLM RAG Flow
   - Query with test question
   - Mock LLM response
   - Verify correct documents retrieved from vector DB
   - Verify answer includes sources

Run: On every PR (CI)
```

### Load Testing
```
Tool: [k6 / Artillery / etc.]
Scenarios:
- Normal load (X req/sec)
- Peak load (Y req/sec)
- Sustained load (Z minutes)
```

**Example:**
```
Tool: k6
Scenarios:
1. Normal: 10 req/sec for 5 minutes
2. Peak: 100 req/sec for 1 minute
3. Sustained: 50 req/sec for 30 minutes

Metrics:
- P95 latency < 500ms
- P99 latency < 1000ms
- Error rate < 0.1%
- Queue processes all jobs within 2x normal time

Run: Monthly + before major releases
```

---

## Deployment

### Infrastructure
```
Platform: [Cloudflare Workers / AWS Lambda / GCP Cloud Run / etc.]
Region: [us-east-1 / Global / etc.]
Auto-scaling: [Yes / No]
```

**Example:**
```
Platform: Cloudflare Workers
- Global edge deployment (300+ locations)
- Auto-scaling (0 to millions of requests)
- Cold start: <5ms

Services:
- Workers: Main application code
- Workers KV: Configuration storage
- D1: SQL database (beta, for non-critical data)
- R2: File storage
- Queues: Background jobs

Database: External Supabase (PostgreSQL)
- Primary: us-east-1
- Read replica: eu-west-1 (future)

Redis: Upstash (global, edge-compatible)
```

### CI/CD
```
On Push:
- [ ] Lint and type check
- [ ] Run unit tests
- [ ] Run integration tests
- [ ] Deploy to staging

On Merge to Main:
- [ ] All above checks pass
- [ ] Deploy to production
- [ ] Run smoke tests
- [ ] Monitor for errors
```

### Rollback Plan
```
If deployment fails:
1. [Auto-rollback if health check fails]
2. [Manual rollback via CLI]
3. [Database migration rollback]
```

**Example:**
```
Deployment:
1. Deploy to staging (automatic on push to develop)
2. Run smoke tests (automated)
3. Manual approval (Slack button)
4. Deploy to production (canary: 10% traffic for 5 min)
5. Monitor error rates and latency
6. If error rate > 1%, auto-rollback
7. If successful, ramp to 100%

Rollback:
- Instant: Cloudflare Workers allows instant version switching
- Database: Migrations are tested in staging first, rarely need rollback
- If needed: wrangler rollback --version previous
```

---

## Cost Management

### LLM Costs
```
Budget: [$X / month]
Model: [Which model, cost per token]
Optimization:
- Prompt caching
- Smaller models for simple tasks
- Cache responses
```

**Example:**
```
Budget: $500/month (Claude API)
Model: Claude Sonnet 4.5
- Input: $3 / 1M tokens
- Output: $15 / 1M tokens
- Prompt caching: 90% discount on cached prompts

Optimization:
- Cache system prompts (reduce input tokens by 70%)
- Cache common user queries (knowledge base Q&A)
- Use Claude Haiku for simple lookups ($0.25 / 1M input)
- Limit context to last 10 messages (vs. full conversation)

Expected monthly cost:
- 1M requests/month
- Avg 1000 tokens/request (input + output)
- 50% cache hit rate
- Estimated: $350/month

Alert if cost exceeds $400/month
```

### Infrastructure Costs
```
Cloudflare Workers: [Free tier / Paid plan]
Database: [$X / month]
Redis: [$X / month]
Monitoring: [$X / month]
Total: [$X / month]
```

**Example:**
```
Monthly Costs:
- Cloudflare Workers: $5 (paid plan, 10M requests/month)
- Supabase: $25 (Pro tier, 8GB database)
- Upstash Redis: $10 (pay-as-you-go, ~1GB)
- Datadog: $15 (log management)
- Sentry: $0 (free tier, <10k events/month)
- LLM (Claude): $350 (see above)

Total: ~$405/month

Scaling estimates:
- 10x traffic: $1,200/month (mostly LLM costs)
- 100x traffic: $8,000/month (need cost optimizations)
```

---

## Runbooks

### Common Operations

**Add New Command:**
```
1. Define command in src/commands/
2. Add Zod schema for input validation
3. Implement handler function
4. Add unit tests
5. Update help text
6. Deploy to staging, test
7. Deploy to production
```

**Update Knowledge Base:**
```
1. Add/update documents in docs/
2. Run embedding generation script
3. Upload embeddings to vector database
4. Invalidate LLM response cache
5. Test with sample queries
```

**Handle LLM Outage:**
```
1. Check status.anthropic.com
2. If Claude down, traffic auto-routes to OpenAI
3. If both down, serve cached responses
4. If no cache, return "AI temporarily unavailable, try again in a few minutes"
5. Log all fallback usage for later analysis
```

---

## Compliance & Ethics

### AI Ethics
```
- No harmful content generation
- Respect user privacy (no logging PII unnecessarily)
- Transparent about being AI (users know they're talking to a bot)
- Escalation path to humans (for complex or sensitive issues)
- Bias monitoring (track if certain queries fail more for specific users)
```

### Data Privacy
```
- GDPR compliance (users can request data deletion)
- Minimal data retention (delete conversation history after 30 days)
- No sharing data with third parties (except LLM providers under DPA)
- Audit logs for all data access
```

**Example:**
```
Bot Disclosure:
- Every response starts with bot indicator (⚡ or [Bot])
- Help text: "I'm an AI assistant. For complex issues, type 'human' to escalate."

Data Handling:
- Conversation history: 30-day retention, then deleted
- Audit logs: 1-year retention (compliance requirement)
- Customer lookups: Logged (who, when, which customer)
- LLM prompts: Not logged in production (contains PII)

User Rights:
- /privacy command: Explains data usage
- /delete-my-data command: Deletes conversation history
- Admins can export user's audit log
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
- ✅ Implement comprehensive error handling and retries
- ✅ Add structured logging with request IDs
- ✅ Validate all inputs (Zod schemas)
- ✅ Respect rate limits (internal and external)
- ✅ Cache aggressively (but invalidate correctly)
- ✅ Make operations idempotent (safe to retry)
- ✅ Handle async operations with queues
- ✅ Monitor costs (LLM tokens, API calls)
- ✅ Test failure scenarios (external API down, LLM timeout)
- ✅ Mark sub-tasks complete [x] after finishing

### Never:
- ❌ Make synchronous calls to slow external APIs (use queues)
- ❌ Skip input validation ("we trust Slack/Discord")
- ❌ Expose internal errors to users (always friendly messages)
- ❌ Hardcode API keys or secrets
- ❌ Log PII without encryption
- ❌ Retry non-retryable errors (400, 404)
- ❌ Execute shell commands with user input
- ❌ Assume external APIs are always available (have fallbacks)
- ❌ Ignore rate limits (respect them or get banned)
- ❌ Build without monitoring (you can't debug what you can't see)

---

## Ready to Build!

This Constitution is your agent's source of truth. Reference it in all AI prompts:

```
@CONSTITUTION.md
@ai-framework/prompts/phase-1-planning/1.1-product-owner-prd.md

I want to build [feature]. Help me create a PRD.
```

**Next Steps:**
1. Fill in all placeholders marked with [brackets]
2. Review with your team
3. Save as `CONSTITUTION.md` in your project root
4. Start building with the [Standard Workflow](../workflow/workflow-overview.md)

🤖 **Build an awesome agent!**
