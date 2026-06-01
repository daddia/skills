# Agent Skills for AI-First Product Delivery

Opinionated skills that guide an AI agent through the full product delivery loop — from strategy and architecture to epics, implementation, review, and sprint-end refinement. Use them in **Cursor**, **Claude Code**, or any [open agent skills](https://github.com/vercel-labs/skills) host.

Each skill produces one clear artefact (a markdown file or code change). Skills chain together: the agent reads what you already wrote and knows what *not* to put in the wrong document.

## What you get

- **A consistent doc model** in your repo — product, roadmap, backlog, solution, per-epic design and tasks, sprint plans.
- **Modes per topic** — `write`, `review`, and `refine` where it matters (e.g. `backlog write`, `tasks review`).
- **Gherkin-first acceptance criteria** in `tasks.md`; optional **EARS** with `--ears` when rules are clearer than scenarios.
- **Clear boundaries** — skills say what they are *not* for, so the agent does not dump architecture into the backlog or tasks into `product.md`.
- **Help when you are unsure** — **skills-index** picks a skill and mode from a vague request.

## Getting started

### Install skills from [skills.sh](https://skills.sh)

```bash
# All skills from this repo
npx skills@latest add daddia/skills

# Or one skill at a time
npx skills@latest add daddia/skills/backlog
```

### Install as a plugin (Cursor or Claude Code)

For the full set in one package — all skills plus review helpers — install the **Space** plugin from this repository:

1. Clone or copy this repo.
2. Place it so `.cursor-plugin/plugin.json` (or `.claude-plugin/plugin.json`) is at the plugin root.
3. In Cursor: `~/.cursor/plugins/local/space/` then reload the window. See [Cursor plugins](https://cursor.com/docs/plugins).

Same skills; the plugin is convenience for local/team use.

### First commands to try

```text
/product write --stage pitch
/roadmap write
/backlog write
/design write checkout-foundation --mode walking-skeleton
/tasks write checkout-foundation
/feature implement CHK01-01
/code-review
/validate checkout-foundation
```

Not sure where to start? Use **skills-index**, or follow the [typical flow](#typical-flow) below.

## Where files live in your project

Default layout the skills expect (override paths in your prompt if your repo differs):

```text
docs/
├── product/
│   ├── product.md
│   ├── roadmap.md
│   └── backlog.md
└── architecture/
    ├── solution.md
    └── decisions/
        ├── register.md
        └── ADR-NNNN-{title}.md

work/
├── checkout-foundation/     # epic — slug from title (max two words)
│   ├── design.md
│   ├── tasks.md
│   └── refine-session.md
└── sprint-3/
    ├── plan.md
    └── retrospective.md
```

**Epic slug `{epic}`** — kebab-case from the epic **title or short title**, at most two words (`Checkout Foundation` → `checkout-foundation`). Epic IDs like `CHK01` stay in the backlog table; resolve the slug from that row when invoking skills.

Full path and boundary rules: [delivery conventions](skills/backlog/references/delivery-conventions.md).

## Typical flow

```text
product → roadmap → backlog → solution (+ adr as needed)
                              ↓
                    design → tasks → feature → code-review
                              ↓
                         validate (epic done?)
                              ↓
              sprint plan / retro, docs refine (ongoing)
```

| Stage | Skills |
| ----- | ------ |
| Strategy | **product**, **roadmap**, **backlog** |
| Architecture | **solution**, **adr** |
| Per epic | **design**, **tasks** |
| Build & ship | **feature**, **code-review**, **create-mr**, **validate** |
| Cadence | **sprint**, **docs** |

For large PRs, **code-review** can use focused sub-agents (AC coverage vs `tasks.md`, scope vs `design.md`) so review stays thorough without one overloaded prompt.

## Skill catalogue

| Skill | Modes | Artefact |
| ----- | ----- | -------- |
| **product** | write, review, refine | `docs/product/product.md` |
| **roadmap** | write, review, refine | `docs/product/roadmap.md` |
| **backlog** | write, review, refine | `docs/product/backlog.md` |
| **tasks** | write, review, refine | `work/{epic}/tasks.md` |
| **solution** | write, review, refine | `docs/architecture/solution.md` |
| **design** | write, review | `work/{epic}/design.md` |
| **docs** | review, refine | review / `work/{epic}/refine-session.md` |
| **adr** | plan, write, review | `register.md`, `ADR-NNNN.md` |
| **sprint** | plan, retrospective | `work/sprint-{id}/plan.md`, `retrospective.md` |
| **feature** | implement | code |
| **code-review** | review, fix | code review / code |
| **validate** | run | validation report |
| **create-mr** | run | MR / PR |
| **skills-index** | run | routing |

Invoke with the mode first: `/tasks write checkout-foundation`, `/sprint plan 3`.

### Planning & strategy

- **product** — Pitch or full `product.md` (_why_, _who_, _what_).
- **roadmap** — Outcome-based phases with exit criteria.
- **backlog** — Epics and work paths; optional `--stories` for small products.

### Architecture & epic delivery

- **solution** — Stub or full arc42-lite `solution.md`.
- **adr** — Proposals in `register.md`; accepted decisions as `ADR-NNNN-{title}.md`.
- **design** — `work/{epic}/design.md` (walking-skeleton or TDD).
- **tasks** — `work/{epic}/tasks.md` with Gherkin AC from design.

### Implementation & sign-off

- **feature** — Implement against approved design and tasks.
- **code-review** — Review a branch or PR; **fix** addresses findings without behaviour changes.
- **validate** — Epic completion vs tasks and roadmap gates.
- **create-mr** — Merge request description from the branch.

### Sprint & documentation

- **sprint** — `plan.md` before the sprint; `retrospective.md` after.
- **docs** — Pre-sprint alignment or sprint-end doc pass on product, solution, and epic design.

### Skill Discovery

- **skills-index** — “Which skill should I use?” for open-ended questions.

## License

Copyright (c) 2026 daddia. All rights reserved. Released under the [MIT](LICENSE).
