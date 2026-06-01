# Tasks — write mode

Break an **epic** into implementable tasks with Gherkin-first acceptance criteria.

Read [SKILL.md](../SKILL.md) and [backlog/SKILL.md](../../backlog/SKILL.md) for `{epic}` slug rules.

## Path

Default: `work/{epic}/tasks.md`. Resolve `{epic}` from the argument or backlog row.

## Arguments

- `--ears` — add EARS to every task (≥2 each); still require Gherkin

## Context

<artifacts>
[Required: work/{epic}/design.md OR user spec
Recommended: docs/product/backlog.md (epic row), docs/architecture/solution.md]
</artifacts>

## Acceptance workflow

1. Gherkin first — ≥1 scenario per task; two when happy path + edge matter
2. If `--ears` — add EARS not redundant with Gherkin
3. Else — EARS only when rules are clearer than scenarios alone; omit section if unused

## Steps

1. Read design.md (or spec), epic in backlog.md, solution.md
2. Summary, conventions, tasks with canonical schema, traceability, DoD, handoff

## Output

[assets/tasks.template.md](../assets/tasks.template.md).
Example: [examples/checkout-foundation.md](../examples/checkout-foundation.md).
