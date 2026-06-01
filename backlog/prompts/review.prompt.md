# Backlog — review mode

Critical review of the **product backlog** for planning readiness.

Read [SKILL.md](../SKILL.md) for path resolution.

## Path

Default: `docs/product/backlog.md`. User-named paths override.

For story-level EARS/Gherkin and sprint feasibility, use **tasks review** on
`work/{wp}/tasks.md` — not this skill.

## Context

<artifacts>
[Required: backlog.md
Recommended: product.md, roadmap.md, solution.md
Optional: retrospective notes]
</artifacts>

## Steps

1. Read backlog.md and context
2. Check alignment with product.md §4–§5 and roadmap current phase
3. Apply epic criteria below; amend unambiguous fixes; report verdict

## Epic review criteria

- Every Now-phase epic traces to product.md §7 outcomes
- No Now-phase epic contradicts product §5 No-gos or roadmap deferred items
- Epic granularity: one integration boundary / phase objective per epic
- Next/Later epics are lightweight unless `--depth full` was used
- Dependency graph matches epic table; no cycles; critical path is sound
- Now-phase epics have estimates (or explicit spike) — not TBD without plan
- Minimum viable slice is truly minimal
- Delivery risks distinct from solution.md §10.1
- If stories appear in product backlog: they are high-level only; flag full Gherkin here as misplaced (belongs in tasks.md)

## Universal criteria

Internal consistency, naming vs solution.md, currency, length discipline for Now vs Later phases.

## Verdict

**Planning-ready**, **Acceptable with amendments**, or **Not ready**.

## Output

Amend backlog.md for non-blocking fixes. Report verdict, findings, remaining risks.
