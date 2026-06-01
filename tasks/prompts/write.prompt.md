# Tasks — write mode

You are a Senior Delivery Engineer breaking a work package into implementable
tasks with **Gherkin-first** acceptance criteria.

Read [SKILL.md](../SKILL.md) for path resolution and the canonical task schema.

## Path

Default: `work/{wp}/tasks.md`. If the user names another path, use it.

## Arguments

- `--ears` — add **Acceptance (EARS)** to every task (≥2 EARS each); still require Gherkin per task

## Context

<artifacts>
[Required: work/{wp}/design.md OR a spec/requirements doc from the user
Recommended: epic entry in docs/product/backlog.md, docs/architecture/solution.md]
</artifacts>

## Acceptance criteria workflow

For each task:

1. Write **Gherkin first** — at least one scenario; two when happy path + important edge matter
2. If `--ears` — add ≥2 EARS statements that are not redundant with Gherkin
3. Else — add **Acceptance (EARS)** only when a rule is awkward to capture in scenarios alone (see SKILL.md). **Omit** the EARS subsection if not needed — do not leave empty headings
4. Never use plain checklist AC without Gherkin

## Steps

1. Read design.md (or the user spec), the parent epic in product backlog.md, and solution.md
2. Write summary: epic ID, phase, priority, total estimate, scope, deliverables, dependencies
3. Define conventions table
4. Write each task using the schema above
5. Traceability to solution sections and product outcomes where applicable
6. Definition of Done and handoff

## Quality rules

- Every task links to design.md (or spec section)
- Do not duplicate the same requirement in EARS and Gherkin
- Do not invent scope outside design/spec and parent epic
- Total estimate should fit one sprint; split or flag if not

## Output

YAML frontmatter + Markdown. Use [assets/tasks.template.md](../assets/tasks.template.md).
Example: [examples/wp01-tasks.md](../examples/wp01-tasks.md).
