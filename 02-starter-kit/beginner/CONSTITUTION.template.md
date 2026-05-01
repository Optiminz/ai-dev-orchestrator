# Constitution — {{PROJECT_NAME}}

The non-negotiable rules of this project. Anything Claude builds must respect this file.

This is a living document. Update it as you learn more about what you're trying to do. If something here turns out to be wrong, change it — but change it deliberately, not by accident.

---

## 1. What this project is

One paragraph, in plain language, describing what this project is.

> *Example: "A simple web tool that lets volunteers at [nonprofit] tag and search a folder of about 30,000 photos. Volunteers upload photos, add a few tags, and can later search for things like 'staff Christmas party 2018'. That's it."*

## 2. Who it's for

Who actually uses this? How many of them? How tech-comfortable are they?

> *Example: "Around 8 volunteers, mostly retired, comfortable with Gmail and Word but not much else. They'll be using a laptop or iPad."*

## 3. What it must do

The core things this project must accomplish. Keep this short. If the list grows past about 5–7 items, you're probably scoping too much for a first version.

- [ ] *Thing 1*
- [ ] *Thing 2*
- [ ] *Thing 3*

## 4. What it explicitly does NOT do

Just as important. Things that sound tempting but are out of scope. Saying no early prevents months of wasted work.

- *Example: "Does NOT support multiple organisations — single-tenant only."*
- *Example: "Does NOT have user accounts or login — anyone with the link can use it."*
- *Example: "Does NOT integrate with any other system."*

## 5. Success looks like

How will you know this project is working? Be specific.

> *Example: "A volunteer can upload 50 photos in under 10 minutes, tag them, and another volunteer can find them again next week without asking how."*

## 6. Constraints

Anything outside the project that limits the choices Claude can make.

- **Budget:** *e.g. "Under $20/month total running cost."*
- **Hosting:** *e.g. "Must be hostable somewhere I can manage without a developer on call."*
- **Data:** *e.g. "Photos are sensitive — must not be publicly indexable."*
- **Time:** *e.g. "Need a working first version in 2 weeks."*

## 7. Working agreements with Claude

Rules of engagement. Edit these freely.

- **Interview before coding.** Claude must ask questions before scaffolding anything.
- **Simplest thing that works.** Default to the boring, obvious solution unless there's a real reason not to.
- **No surprise dependencies.** Claude must ask before adding a new framework, package, or paid service.
- **Show diffs.** Every change explained in plain language before it's accepted.
- **Flag scope creep.** If a request goes beyond what this constitution describes, Claude says so.

---

## How to update this file

When something here changes (the project pivots, a new constraint emerges, you decide to drop a feature), update this file *first*, then tell Claude. Code that doesn't match the constitution gets changed; the constitution doesn't get bent to match the code.
