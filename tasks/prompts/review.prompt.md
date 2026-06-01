# Tasks — review mode

Critical review of `tasks.md` for sprint readiness — not a grooming session.

Read [SKILL.md](../SKILL.md) for path resolution.

## Path

Default: `work/{wp}/tasks.md`. User-named paths override.

## Context

<artifacts>
[Required: tasks.md
Recommended: design.md, docs/product/backlog.md (parent epic), solution.md]
</artifacts>

## Steps

1. Read tasks.md and all context
2. Confirm alignment with parent epic and design.md
3. Apply criteria below; amend unambiguous fixes; report verdict

## Review criteria

**Sprint feasibility.** Total estimate fits one sprint? P0 tasks unblocked?

**Task independence.** Each task developable, reviewable, and mergeable independently?

**Acceptance criteria.** Every task has ≥2 EARS + 1 Gherkin; EARS testable; Gherkin `Then` is observable.

**Traceability.** Each task links to design.md; traces to product outcome where applicable.

**Definition of Done.** Matches project standards (tests, lint, typecheck, review, merge).

**Task quality.** No pure implementation chores disguised as user-facing tasks without justification; split oversized tasks.

**Naming.** Consistent with solution.md ubiquitous language.

## Verdict

**Sprint-ready**, **Acceptable with amendments**, or **Not ready** (blocking findings must be resolved in **refine** mode).

## Output

Amend tasks.md for non-blocking fixes. Report verdict, blocking/non-blocking findings, remaining risks.
