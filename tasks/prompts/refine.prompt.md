# Tasks — refine mode

Refine `tasks.md` so the team can start the next sprint without ambiguity.

Read [SKILL.md](../SKILL.md) for path resolution.

## Path

Default: `work/{wp}/tasks.md`. User-named paths override.

## The five activities

Apply to every task in scope:

1. **Prioritise** — unblockers first; ready tasks above blocked ones
2. **Break down** — split if estimate > 8 or multiple testable behaviours per task
3. **Estimate** — fill or update; TBD only with a spike task
4. **Define acceptance criteria** — full EARS + Gherkin per SKILL.md
5. **Remove** — defer tasks misaligned with design or epic; record in summary

## Steps

1. Read tasks.md, design.md, parent epic
2. Remove → break down → prioritise → estimate → tighten AC
3. Update `version`, `last_updated`, `status: Refined`
4. Report changes and sprint-ready verdict

## Output

Amend tasks.md only. Report removed, split, reprioritised, estimates, AC, verdict, blockers.
