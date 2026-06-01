# Backlog — review mode

Critical review of the **product backlog** for planning readiness.

Read [SKILL.md](../SKILL.md) for path resolution and epic work folders.

## Path

Default: `docs/product/backlog.md`. User-named paths override.

For Gherkin and sprint feasibility, use **tasks review** on `work/{epic}/tasks.md`.

## Context

<artifacts>
[Required: backlog.md
Recommended: product.md, roadmap.md, solution.md
Optional: sprint retrospective notes]
</artifacts>

## Steps

1. Read backlog.md and context
2. Check alignment with product.md §4–§5 and roadmap current phase
3. Verify each epic has a valid `work/{epic}/` path (title or short title slug, max two words)
4. Apply epic criteria; amend unambiguous fixes; report verdict

## Epic review criteria

- Now-phase epics trace to product.md §7 outcomes
- No contradiction with product §5 or roadmap deferred items
- Epic granularity: one integration boundary / phase objective per epic
- Work paths are unique and match title or short title slugs
- Dependencies and estimates sound
- Stories in product backlog are high-level only — flag full Gherkin as misplaced

## Verdict

**Planning-ready**, **Acceptable with amendments**, or **Not ready**.

## Output

Amend backlog.md for non-blocking fixes. Report verdict, findings, remaining risks.
