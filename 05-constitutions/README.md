# Project Constitution Templates

Choose a template based on your project type and customize it for your specific needs.

## Available Templates

### 1. Internal Tool (`internal-tool-constitution.md`)
**Best for:** Team tools, admin dashboards, internal utilities

**Characteristics:**
- Simplified rules and standards
- Function over form (doesn't need to be beautiful)
- Minimal security (basic auth is fine)
- Fast iteration and shipping
- Small user base (your team)

**Use when:**
- Building for 5-50 internal users
- Speed to market is critical
- The tool solves a specific workflow problem
- You don't need enterprise-grade security

**Examples:**
- Team task tracker
- Expense reporting tool
- Internal documentation system
- Admin dashboard
- Data import/export utility

---

### 2. Client Application (`client-app-constitution.md`)
**Best for:** Client-facing apps, SaaS products, public tools

**Characteristics:**
- Professional standards and polish
- Security-focused (auth, data protection)
- Comprehensive documentation required
- Quality assurance and testing
- Unknown/untrusted users

**Use when:**
- Building for clients or customers
- The app represents your brand
- Security and reliability are critical
- You need scalability
- Users may be non-technical

**Examples:**
- SaaS application
- Client portal
- E-commerce platform
- Public-facing web app
- Mobile app backend

---

### 3. AI Agent/Bot (`ai-agent-constitution.md`)
**Best for:** AI agents, bots, API-first services, automation tools

**Characteristics:**
- API-first design (minimal/no UI)
- Rate limiting and quota management
- Error handling and retry logic
- Integration-focused
- Monitoring and logging

**Use when:**
- Building an AI chatbot or agent
- Creating an API-only service
- Automating workflows
- Integrating with external services
- Need robust error handling

**Examples:**
- Slack bot
- Discord bot
- API service for AI integrations
- Workflow automation agent
- Data processing pipeline

---

## How to Use These Templates

### Step 1: Choose Your Template

Select the template that best matches your project type. If unsure:

**Ask yourself:**
- Who will use this? (Internal team → Internal Tool, Customers → Client App, Machines → AI Agent)
- What's the priority? (Fast iteration → Internal Tool, Security → Client App, Integration → AI Agent)
- How will it be accessed? (Web UI → Internal/Client, API → AI Agent)

### Step 2: Copy to Your Project

```bash
# Navigate to your project
cd ~/my-project

# Copy the template you chose
cp /path/to/ai-dev-orchestrator/templates/internal-tool-constitution.md ./CONSTITUTION.md

# Or for client apps:
# cp /path/to/ai-dev-orchestrator/templates/client-app-constitution.md ./CONSTITUTION.md

# Or for AI agents:
# cp /path/to/ai-dev-orchestrator/templates/ai-agent-constitution.md ./CONSTITUTION.md
```

### Step 3: Customize for Your Project

Open `CONSTITUTION.md` and fill in the placeholders:

**Required customizations:**
- [ ] Project name and description
- [ ] Tech stack (framework, database, styling)
- [ ] User context (who will use this, how many)
- [ ] Security requirements (authentication, data protection)
- [ ] Deployment platform (Vercel, Replit, AWS, etc.)

**Optional but recommended:**
- [ ] Coding standards specific to your team
- [ ] Testing approach
- [ ] File structure preferences
- [ ] Third-party service integrations (Stripe, SendGrid, etc.)

### Step 4: Review with AI

Before building, validate your Constitution:

```
Review my CONSTITUTION.md file. Check for:
- Missing information that would impact development
- Contradictions or unclear instructions
- Technologies that don't work well together
- Security gaps for this type of application

Suggest improvements.
```

### Step 5: Start Building

Reference your customized CONSTITUTION.md in all AI prompts:

```
@CONSTITUTION.md
@ai-framework/quick-start/simple-workflow.md

I want to build [feature]. Help me create a PRD.
```

---

## Customization Guide

### What to Keep

✅ **Keep the structure** - The sections are organized for AI comprehension
✅ **Keep the examples** - They help the AI understand your preferences
✅ **Keep security sections** - Even for internal tools, basics matter

### What to Change

🔧 **Tech stack** - Replace with your actual technologies
🔧 **User context** - Describe your specific users and use cases
🔧 **File structure** - Match your project's organization
🔧 **Third-party services** - Add APIs and services you'll integrate
🔧 **Out of scope** - List what you explicitly won't build

### What to Add

➕ **Team conventions** - Specific to your team's preferences
➕ **Industry requirements** - Compliance, regulations (HIPAA, GDPR)
➕ **Performance targets** - If critical (e.g., < 200ms API response)
➕ **Accessibility requirements** - WCAG compliance levels
➕ **Branding guidelines** - Colors, fonts, tone for client apps

### What to Remove

➖ **Sections you don't need** - If not using a database, remove database section
➖ **Placeholder examples** - Replace with your real examples
➖ **Optional features** - If you'll never use WebSockets, remove that section

---

## Template Comparison

| Aspect | Internal Tool | Client App | AI Agent/Bot |
|--------|--------------|------------|--------------|
| **UI Polish** | Basic (functional) | High (professional) | Minimal (API focus) |
| **Security** | Basic auth | Enterprise-grade | API keys, rate limits |
| **Documentation** | Light (README) | Comprehensive | API docs required |
| **Testing** | Manual mostly | Automated required | Integration tests |
| **Error Handling** | User-friendly | Graceful degradation | Retry logic, logging |
| **Performance** | "Good enough" | Optimized | Async, queues |
| **Deployment** | Simple (Replit, Vercel) | Production-ready | Always-on, monitored |
| **Scalability** | 5-50 users | 1000s of users | API rate-based |

---

## Mixing Templates

You can combine templates if your project spans multiple categories:

**Example: Internal tool with AI features**
```markdown
# Constitution: Sales Assistant Bot (Internal)

Base template: internal-tool-constitution.md
Added sections from: ai-agent-constitution.md

## Overview
An internal Slack bot that helps our sales team look up customer data.
Combines internal tool simplicity with bot-specific error handling.

[Rest of constitution using internal tool template + bot sections]
```

**Example: Client app with API**
```markdown
# Constitution: SaaS App with Public API

Base template: client-app-constitution.md
Added sections from: ai-agent-constitution.md (API Design section)

## Overview
A client-facing SaaS application that also offers a public API.
Requires both UI polish and robust API design.

[Rest of constitution using client app template + API sections]
```

---

## Evolution Path

Your Constitution can evolve as your project grows:

### Week 1: Start Simple
```markdown
# Constitution: Team Task Tracker

Base: internal-tool-constitution.md
Scope: 5-person team, basic CRUD
```

### Month 3: Add Features
```markdown
# Constitution: Team Task Tracker v2

Base: internal-tool-constitution.md
Added: Real-time updates, file attachments
Updated security: Added file upload validation
```

### Month 6: External Users
```markdown
# Constitution: Task Tracker Pro

Migrated to: client-app-constitution.md
Added: Multi-tenant architecture, payment integration
Enhanced: Security, testing, documentation
```

**Pro tip:** Keep old versions in `docs/constitution-history/` to see how your project evolved.

---

## Common Pitfalls

### ❌ Mistake: "Too Generic"
```markdown
Tech Stack: Modern web stack
```
**Problem:** AI doesn't know what to use

**Fix:**
```markdown
Tech Stack:
- Framework: Next.js 14 (App Router)
- Database: PostgreSQL 15 via Supabase
- Styling: Tailwind CSS 3
- Auth: Supabase Auth
```

### ❌ Mistake: "Too Vague About Users"
```markdown
User Context: People who need to track tasks
```
**Problem:** AI can't optimize for the actual use case

**Fix:**
```markdown
User Context:
- Users: 5-person marketing team (non-technical)
- Access: Web only (desktop and mobile browsers)
- Frequency: Daily use, 10-20 tasks per person
- Location: Remote team across US time zones
```

### ❌ Mistake: "Contradictory Requirements"
```markdown
Priority: Ship fast, minimal features
Also needs: Enterprise-grade security, 99.9% uptime
```
**Problem:** Fast iteration conflicts with enterprise requirements

**Fix:** Pick one:
```markdown
Priority: Ship fast (internal tool, iterate based on feedback)
Security: Basic (password auth, no sensitive data)
```

### ❌ Mistake: "Copy-Paste Without Customization"
```markdown
[Use the framework specified in CONSTITUTION.md]
```
**Problem:** You didn't fill in the framework!

**Fix:** Replace all placeholders:
```markdown
Framework: Express.js (Node.js 18)
```

---

## Validation Checklist

Before using your CONSTITUTION.md, verify:

**Tech Stack Section:**
- [ ] Framework and version specified
- [ ] Database choice and connection method
- [ ] Styling approach defined
- [ ] Authentication method chosen
- [ ] All choices work together (no conflicts)

**User Context Section:**
- [ ] Number of users specified
- [ ] User technical level described
- [ ] Access method defined (web, mobile, API)
- [ ] Use frequency and patterns noted

**Security Section:**
- [ ] Authentication approach chosen
- [ ] Data protection measures defined
- [ ] Input validation requirements stated
- [ ] Appropriate for user context (not over/under-engineered)

**Coding Standards Section:**
- [ ] File structure example provided
- [ ] Error handling pattern shown
- [ ] Testing approach defined
- [ ] Code example format matches your stack

**Out of Scope Section:**
- [ ] Lists features you're NOT building (yet)
- [ ] Prevents scope creep
- [ ] Clear boundaries set

---

## Need Help Choosing?

Still not sure which template to use? Answer these questions:

1. **Who are the users?**
   - My team only → Internal Tool
   - Customers/clients → Client App
   - Other systems/APIs → AI Agent

2. **What's the main interface?**
   - Web pages with forms → Internal Tool or Client App
   - Mostly API calls → AI Agent
   - Chat/messaging → AI Agent

3. **What's the top priority?**
   - Speed to market → Internal Tool
   - Security and quality → Client App
   - Reliability and integration → AI Agent

4. **How many users (eventually)?**
   - 5-50 → Internal Tool
   - 100-10,000+ → Client App
   - N/A (API-based) → AI Agent

5. **What's the budget for infrastructure?**
   - Minimal (free tier) → Internal Tool
   - Moderate (paid hosting) → Client App
   - Variable (usage-based) → AI Agent

**Still unsure?** Start with **Internal Tool** template. It's the simplest. You can always upgrade to Client App later as your needs grow.

---

## Next Steps

1. **Choose your template** based on project type
2. **Copy to CONSTITUTION.md** in your project root
3. **Customize all sections** with your specific details
4. **Validate with AI** to catch any issues
5. **Start building** using [Quick Start Guide](../quick-start/README.md)

---

## Real Examples

Want to see real CONSTITUTION.md files in action? Check out these complete examples:

- **[Internal Tool:](../examples/internal-tool/CONSTITUTION.md)** Team expense tracker for 10-person sales team
- **[Client App:](../examples/client-app/CONSTITUTION.md)** SaaS analytics dashboard (production-grade)
- **[AI Agent:](../examples/ai-agent/CONSTITUTION.md)** Slack customer support bot

**See what the output looks like:**
- **[Sample PRD](../examples/sample-outputs/sample-prd.md)** - Product requirements document (dark mode feature)
- **[Sample Tech Spec](../examples/sample-outputs/sample-tech-spec.md)** - Technical specification (dark mode implementation)

**Want to contribute an example?** Open a PR!

---

**Ready to create your Constitution?** Choose a template above and customize it for your project! 🚀
