# Constitution: SupportBot - Slack Customer Support Agent

**Type:** AI Agent / Bot
**Created:** 2025-01-15
**Last Updated:** 2025-01-15

---

## Project Overview

**Name:** SupportBot

**Purpose:** An AI-powered Slack bot that monitors our #customer-support channel, answers common questions using our knowledge base, and escalates complex issues to human agents. Reduces response time from hours to seconds for common questions, freeing up our 3-person support team to handle complex cases.

---

## Core Principles

**Remember:** This is an always-on service with external dependencies:

1. **Reliability first** - Bot must handle errors gracefully
2. **Fast responses** - Users expect instant replies from bots
3. **Fail safely** - When uncertain, escalate to human (don't hallucinate)
4. **Monitor everything** - Log all interactions for analysis
5. **Respect rate limits** - Don't spam users or APIs

---

## Technical Stack

### Runtime Environment
```
Runtime: Node.js 20 LTS
Language: TypeScript 5+ (strict mode)
Process manager: PM2 (for restarts)
Why: Stable, well-supported for bot development
```

### Framework
```
Bot framework: Bolt for JavaScript (Slack SDK)
Web framework: Express (for webhook endpoints)
Why: Official Slack SDK, handles auth and event parsing
```

### AI/LLM
```
Provider: OpenAI GPT-4
Model: gpt-4-turbo (faster, cheaper than gpt-4)
Context window: 128k tokens
Fallback: GPT-3.5-turbo if GPT-4 rate limited
Vector DB: Pinecone (for knowledge base retrieval)
Embeddings: OpenAI text-embedding-3-small
```

### Database
```
Primary: PostgreSQL 15 (Supabase)
Purpose: Conversation logs, user preferences, escalation queue
Caching: Redis (for rate limiting, session state)
Why: Need persistence + fast in-memory cache
```

### Message Queue
```
Queue: BullMQ (Redis-backed)
Purpose: Process long-running tasks async
Use cases:
  - Knowledge base updates
  - Batch analytics
  - Retry failed API calls
```

### Monitoring & Logging
```
Logging: Winston (structured JSON logs)
Metrics: Prometheus + Grafana
Error tracking: Sentry
Uptime: Better Uptime (https://betteruptime.com)
Log retention: 30 days
```

---

## Integration Details

### Slack API
```
Bot token: xoxb-* (OAuth token)
Scopes required:
  - app_mentions:read
  - channels:history
  - channels:read
  - chat:write
  - users:read
Events subscribed:
  - app_mention
  - message.channels (in #customer-support only)
Rate limits: Tier 3 (50+ requests/minute)
Retry strategy: Exponential backoff (1s, 2s, 4s, 8s)
```

### OpenAI API
```
API key: sk-*
Rate limits: 10,000 TPM (tokens per minute)
Retry strategy: Exponential backoff with jitter
Timeout: 30 seconds per request
Cost monitoring: Alert if daily spend > $10
```

### Pinecone Vector DB
```
Index: support-kb (1536 dimensions)
Namespaces: product-docs, troubleshooting, billing
Upsert: Batch updates (max 100 vectors)
Query: Top 5 results, similarity threshold 0.75
```

---

## User Context

**Who interacts:**
- Internal support team (3 people)
- Customers via Slack Connect channels (50+ customers)
- Engineering team (for technical escalations)

**Usage patterns:**
- 24/7 availability expected
- Peak hours: 9am-5pm EST weekdays
- ~100 questions per day
- Response time expectation: < 10 seconds

**Question types:**
- 40%: How-to questions (covered in docs)
- 30%: Account/billing questions
- 20%: Bug reports
- 10%: Feature requests

---

## Security Requirements

### Authentication & Authorization
- Slack signature verification on all webhooks
- API keys stored in environment variables (never in code)
- Rate limiting per user (5 requests/minute)
- Admin commands require Slack workspace admin role

### Data Protection
- No PII in logs (scrub before logging)
- Customer conversation data:
  - Stored encrypted at rest
  - Retained for 90 days, then deleted
  - Accessible only to support team leads
- OpenAI API:
  - Use "zero data retention" option
  - Don't send PII to OpenAI

### Input Validation
- Sanitize all user input before processing
- Reject messages > 2000 characters
- Block known spam patterns
- Verify webhook signatures before processing

---

## Coding Standards

### File Structure
```
src/
  bot/
    index.ts
    handlers/
      app-mention.ts
      message.ts
      slash-commands.ts
    middleware/
      auth.ts
      rate-limit.ts
  ai/
    openai.ts
    embeddings.ts
    knowledge-base.ts
  database/
    models/
    migrations/
  queue/
    workers/
  utils/
    logger.ts
    slack-client.ts
  config/
    index.ts
```

### Naming Conventions
- Files: kebab-case
- Classes: PascalCase
- Functions: camelCase
- Constants: UPPER_SNAKE_CASE
- Environment variables: UPPER_SNAKE_CASE

### Code Style
- TypeScript strict mode
- ESLint + Prettier
- All async functions use async/await (no .then())
- Error handling: Every async call wrapped in try/catch
- Logging: Structured logs with context

### Error Handling Patterns
```typescript
// Good: Graceful degradation
try {
  const answer = await openai.ask(question);
  await slack.postMessage(answer);
} catch (error) {
  logger.error('OpenAI failed', { error, question });
  await slack.postMessage(
    "I'm having trouble right now. A human agent will help you shortly."
  );
  await escalateToHuman(question);
}
```

---

## Features & Scope

### What We're Building (MVP)

**Core Bot Features:**
1. Respond to @mentions in #customer-support
2. Answer questions using knowledge base (RAG pattern)
3. Escalate to human when:
   - Confidence score < 0.7
   - User explicitly asks for human
   - Question involves billing/refunds
4. Admin slash commands:
   - `/supportbot stats` - Daily usage stats
   - `/supportbot reload-kb` - Refresh knowledge base

**Knowledge Base:**
1. Index product documentation
2. Index troubleshooting guides
3. Index FAQs
4. Auto-update when docs change (webhook from docs site)

**Analytics:**
1. Track questions answered vs. escalated
2. Track average response time
3. Track user satisfaction (thumbs up/down reactions)
4. Daily summary posted to #support-team

### What We're NOT Building Yet

- ❌ Multi-language support (English only)
- ❌ Voice/video call integration
- ❌ Proactive outreach (only reactive)
- ❌ Ticket creation in Zendesk (manual for now)
- ❌ Learning from human responses (future iteration)

---

## Performance Requirements

**Target SLAs:**
- Response time: < 10 seconds (p95)
- Uptime: 99.5%
- API availability: Graceful degradation if OpenAI is down

**Optimization strategies:**
- Cache frequent questions/answers (Redis, 1hr TTL)
- Parallel processing: Retrieve from KB while calling OpenAI
- Connection pooling for database
- Batch updates to analytics DB

---

## Rate Limiting & Throttling

**Incoming requests (per user):**
- 5 requests per minute
- 50 requests per hour
- Response: "You're asking too fast. Please wait a moment."

**Outgoing API calls:**
- OpenAI: Max 8 concurrent requests
- Slack: Max 1 request per second (Tier 3 limits)
- Pinecone: Max 10 concurrent queries

**Queue processing:**
- Process knowledge base updates: 1 per minute
- Process analytics aggregation: Every 5 minutes

---

## Error Handling & Retries

### Retry Strategy
```
Slack API errors:
  - 429 (rate limit): Wait specified time + jitter
  - 500s: Retry 3 times with exponential backoff
  - 400s: Log and skip (don't retry client errors)

OpenAI API errors:
  - Rate limit: Wait and retry (up to 3 times)
  - Timeout: Retry once with longer timeout
  - Model overload: Fall back to GPT-3.5-turbo

Database errors:
  - Connection lost: Retry 5 times
  - Deadlock: Retry with jitter
```

### Fallback Behavior
```
If OpenAI unavailable:
  → Try cached response
  → If no cache, escalate to human

If Pinecone unavailable:
  → Use backup static FAQ responses
  → Log incident

If Redis unavailable:
  → Skip rate limiting (allow through)
  → Skip caching (direct to OpenAI)
```

---

## Logging & Monitoring

### Structured Logging
```typescript
logger.info('Question answered', {
  userId: 'U12345',
  question: 'How do I reset my password?',
  confidenceScore: 0.92,
  responseTime: 1.2,
  source: 'knowledge-base',
});
```

### Metrics to Track
- Questions received (per hour)
- Questions answered vs. escalated
- Average confidence score
- OpenAI API latency
- Cache hit rate
- Error rate by type

### Alerts
- Error rate > 5% in 5 minutes → Page on-call
- OpenAI API down → Slack alert to #engineering
- Daily question volume > 200 → Slack alert to #support-team
- Response time > 30s (p95) → Investigate

---

## Deployment

**Platform:** Railway.app (Dockerfile deployment)
**Environment:** Single production environment (no staging)

**Dockerfile:**
```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
CMD ["npm", "run", "start:prod"]
```

**Environment Variables:**
```
NODE_ENV=production
SLACK_BOT_TOKEN=xoxb-*
SLACK_SIGNING_SECRET=
OPENAI_API_KEY=sk-*
PINECONE_API_KEY=
PINECONE_INDEX_NAME=
DATABASE_URL=
REDIS_URL=
SENTRY_DSN=
```

**Health Check Endpoint:**
```
GET /health
Returns: { status: 'ok', uptime: 12345 }
```

**Graceful Shutdown:**
- On SIGTERM: Stop accepting new messages
- Finish processing current messages (max 30s wait)
- Close database connections
- Exit

---

## Knowledge Base Management

### Content Sources
1. Product docs (Markdown files)
2. Troubleshooting guides
3. FAQs
4. Common Slack conversations (approved by team lead)

### Update Process
```
1. Docs updated in Git repo
2. Webhook triggers /api/kb/update
3. Bot chunks new content
4. Generate embeddings via OpenAI
5. Upsert to Pinecone
6. Post success message to #support-team
```

### Quality Control
- Human review of AI responses (spot check 10% daily)
- Weekly review of escalated questions (identify KB gaps)
- Track "thumbs down" reactions (indicates bad response)

---

## Testing Strategy

**Unit Tests:**
- All utility functions
- Slack message parsing
- OpenAI prompt construction

**Integration Tests:**
- Mock Slack API responses
- Mock OpenAI API responses
- Test retry logic with simulated failures

**End-to-End Tests:**
- Not automated (manual testing in test Slack workspace)
- Test scenarios:
  - Ask simple question → Get answer
  - Ask complex question → Escalate to human
  - Spam bot → Rate limited
  - OpenAI down → Graceful fallback

**Coverage:** Minimum 60% (not critical path application)

---

## Incident Response

### Common Issues & Fixes

**Bot not responding:**
1. Check Railway logs
2. Check Slack event subscriptions (URL valid?)
3. Check API keys (expired?)
4. Restart service if needed

**Wrong answers:**
1. Review conversation in logs
2. Check knowledge base for relevant docs
3. If missing, add to KB and re-index
4. If hallucination, adjust system prompt

**High OpenAI costs:**
1. Check request volume (DDoS?)
2. Check if caching working
3. Review prompts (too long?)
4. Consider fallback to GPT-3.5 more aggressively

---

## AI Instructions

When generating code for this project:

1. **Reliability over features** - Handle all edge cases
2. **Fail gracefully** - Never let bot crash and go offline
3. **Log everything** - We need to debug in production
4. **Async/await** - All I/O must be async
5. **Type safety** - Full TypeScript types
6. **Idempotency** - Webhook handlers must be idempotent
7. **Rate limiting** - Respect all API limits
8. **Monitoring** - Add metrics for everything important
9. **Retries** - Implement backoff for all external APIs
10. **Documentation** - Comment all non-obvious bot behavior

---

**This bot represents our company to customers 24/7. Reliability and correctness are critical.**
