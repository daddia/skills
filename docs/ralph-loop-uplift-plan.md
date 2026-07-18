# Ralph loop: review and uplift plan

**Date:** 19/07/2026
**Scope:** `skills/ralph`, `hooks/cursor/`, `hooks/claude/`, plugin manifests
**Status:** Plan for approval. No code changed yet.

---

## Summary

Your implementation is materially ahead of both reference plugins on design: it has a step machine, per-run state, budgets, a stall guard, and cross-agent hooks. Neither reference has any of that.

Where it is behind is the plumbing. The loop stops after the first iteration because of defects in the two hook scripts and the Cursor hook config, not because of the skill's design. Four are confirmed by reading the code, and each one alone is enough to kill the loop silently.

The plan below is five phases. Phase 1 fixes the loop. Phases 2 to 5 deliver the rename, the setup split, the directory change, and the generalised templates.

---

## Part 1: Research findings

### Reference A: `ericzakariasson/ralph-loop-plugin` (Cursor)

Three skills (`ralph-loop`, `cancel-ralph`, `ralph-loop-help`), two hooks, no state machine.

- `afterAgentResponse` hook (`capture-response.sh`) scans the response text for `<promise>`, writes a `done` flag.
- `stop` hook reads `.cursor/ralph/scratchpad.md`, parses YAML frontmatter, re-feeds the body as `followup_message`.
- State file is a fixed path. No pointer file, no run directory, no stall guard, no session isolation.

**Verdict:** you already implement a superset. The only thing worth borrowing is the two-hook split for Cursor, which you have. Nothing to take.

### Reference B: `anthropics/claude-plugins-official/plugins/ralph-loop`

No skills at all. Two slash **commands**, one hook, one setup script.

- `/ralph-loop` is a command whose body runs `scripts/setup-ralph-loop.sh` through an inline `!` bash block, then contains the standing instruction to work the task.
- The setup script parses flags in bash, validates them, writes `.claude/ralph-loop.local.md`, and prints a long CRITICAL block about not lying to escape the loop.
- The Stop hook reads the transcript and detects the promise.

Three things in this implementation are better than yours and should be adopted:

**1. Setup is deterministic, not agent-authored.** Flag parsing, validation, and state-file writing happen in a shell script, in the same turn as the work instruction. Your setup asks the agent to substitute fifteen `{{PLACEHOLDER}}` tokens by hand across three templates. Your own `setup.prompt.md` lists "Leaving any `{{PLACEHOLDER}}` unsubstituted in a written file" as an anti-pattern, which is an admission that this fails in practice. An unsubstituted `{{MAX_ITERATIONS}}` in the frontmatter makes the hook's numeric validation fail, which deletes the loop file and stops the loop.

**2. Transcript parsing that actually works.** Claude Code writes every content block (text, tool_use, thinking) as its own JSONL line, all tagged `role:assistant`. The official hook slurps the last 100 assistant lines and takes the last *text* block:

```bash
LAST_LINES=$(grep '"role":"assistant"' "$TRANSCRIPT_PATH" | tail -n 100)
LAST_OUTPUT=$(echo "$LAST_LINES" | jq -rs '
  map(.message.content[]? | select(.type == "text") | .text) | last // ""
')
```

Yours takes `tail -1` of the assistant lines and reads text blocks from that single line. When a turn ends on a tool call, which is the common case for a loop that delegates every step to a sub-agent, that line has no text block and the promise is never seen. **Your loop can only detect completion on turns that happen to end with prose.**

**3. Session isolation.** The official state file records `session_id`, and the hook exits early if the firing session is not the one that started the loop. Without it, every other Claude session open in the same repo gets hijacked into your loop. Yours has no such check.

Also worth taking: their Windows note (Git Bash vs WSL bash path resolution) and the "do not circumvent the loop" wording, which is stronger than yours.

### Comparison

| Capability | ericzakariasson | anthropic official | yours |
| --- | --- | --- | --- |
| Command surface | 3 skills | 2 commands | 1 skill, 4 modes |
| Setup mechanism | agent | shell script | agent (15 placeholders) |
| Step machine | no | no | **yes** |
| Per-run state file | no | no | **yes** |
| Fix budgets | no | no | **yes** |
| Stall guard | no | no | **yes** |
| Sub-agent isolation | no | no | **yes** |
| Cursor + Claude | Cursor only | Claude only | **both** |
| Session isolation | no | **yes** | no |
| Correct transcript parse | n/a | **yes** | no |
| Deterministic frontmatter | fixed path | script-written | agent-written |

---

## Part 2: Why the loop stops after the first iteration

Ranked by confidence. Items 1 to 4 are confirmed from the source.

### 1. Unguarded pipeline under `set -euo pipefail` (both hooks) — CONFIRMED

`hooks/claude/stop-hook.sh` line 21 and `hooks/cursor/ralph-stop.sh` line 27:

```bash
set -euo pipefail
...
RALPH_BASE=$(cat ".ralph-loop" 2>/dev/null | head -1 | tr -d '[:space:]')
```

This is the first substantive command in both scripts, before any existence guard. If `.ralph-loop` is absent or unreadable, `cat` returns 1, `pipefail` propagates it as the pipeline status, and `set -e` kills the script immediately. The hook exits non-zero having printed nothing, Claude Code and Cursor both treat that as a non-blocking error, and the session is allowed to end.

The result is exactly your symptom: the loop runs, the turn ends, and it silently never comes back.

The pointer file is fragile in three ways at once. It is written by the agent during setup rather than by a script. It is read with a relative path, so it fails whenever the hook's working directory is not the project root. And it is not in `.gitignore`, so it is invisible to anyone reviewing the repo and easy to lose to a clean.

**Fix:** guard existence before the pipeline, add `|| true` to every command substitution, and resolve paths from `$CLAUDE_PROJECT_DIR` / `$CURSOR_PROJECT_DIR` rather than the relative cwd. Better still, remove the pointer file entirely (see Part 3).

### 2. `"loop_limit": null` in the Cursor hook config — CONFIRMED for Cursor

`hooks/cursor/hooks.json`:

```json
"stop": [{ "command": "./hooks/cursor/ralph-stop.sh", "loop_limit": null }]
```

Cursor's stop hook `loop_limit` caps how many times the hook may re-trigger a turn. It expects an integer. Passing `null` either fails schema validation or falls back to the conservative default. Either way, the hook is permitted a small number of continuations and then Cursor stops honouring it, which produces one or two iterations and then a stop.

The command path is also relative (`./hooks/cursor/...`), which only resolves if Cursor invokes hooks with cwd set to the plugin root.

**Fix:** set `loop_limit` to an explicit high integer, and make the command path absolute via the plugin root variable.

### 3. Broken transcript parse means the promise is read from the wrong place — CONFIRMED for Claude

Detailed in Part 1. Two failure modes:

- Turn ends on a tool call, so no text block exists on the last line and the promise is missed. The loop overruns to `max_iterations` instead of completing.
- The `jq` call is wrapped in `|| echo ""` but sits inside `set -e` with no `set +e` around it. The official plugin explicitly disables errexit around this call for that reason. A malformed line kills the hook, and the loop dies.

**Fix:** adopt the official plugin's `tail -n 100` + `jq -rs` approach verbatim, with the `set +e` / `set -e` fence around it.

### 4. Frontmatter parser reads 136 lines of prompt body as frontmatter — CONFIRMED

Both hooks parse with:

```bash
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$LOOP_FILE")
```

`sed` ranges restart after each closing match. `assets/loop.template.md` has `---` on lines 1, 6, 47 and 184. So the parser captures lines 2 to 5 (the real frontmatter) **and** lines 48 to 183 (a third of the prompt body). I verified this: the parse returns 108 non-blank lines instead of 4.

Today it survives on luck, because no body line happens to start with one of the four keys. The moment a preset, an example, or a user-supplied ad-hoc prompt contains a line beginning `iteration:` or `max_iterations:`, `grep` returns two matches, the numeric validation fails, and the hook's `cleanup()` **deletes the loop file** and stops the loop. Unrecoverable, with a misleading "loop file corrupted" message.

This is a landmine directly under the generalised-template work in Phase 5.

**Fix:** bound the parse to the first block only, e.g. `awk 'NR==1 && /^---$/{f=1;next} f && /^---$/{exit} f'`.

### 5. Contributing factors (not independently fatal)

- **No `stop_hook_active` check.** Claude Code sets this once the Stop hook has already caused a continuation. Not enforced, but the documented convention, and its absence makes runaway behaviour harder to reason about.
- **No session isolation**, per Part 1.
- **Agent-authored frontmatter.** Any unsubstituted `{{MAX_ITERATIONS}}` fails `^[0-9]+$` and triggers the delete-and-stop path.
- **`hooks/claude/stop-hook.sh` never uses `$CLAUDE_PROJECT_DIR`**, while the Cursor script does use `$CURSOR_PROJECT_DIR`. An asymmetry with no justification.

---

## Part 3: Target design

### Naming and command surface

| Now | Target |
| --- | --- |
| `skills/ralph` (`/ralph setup\|start\|status\|cancel`) | `skills/ralph-loop` (`/ralph-loop start\|status\|cancel`) |
| `setup` mode inside the same skill | `skills/ralph-loop-setup` (`/ralph-loop-setup`) |

Two skills, clean separation. Setup writes files and never executes. `ralph-loop` executes and never seeds, except for the inline ad-hoc case.

Splitting setup out also fixes a description problem. The current `description` frontmatter has to cover seeding, starting, inspecting and cancelling in one paragraph, which blunts trigger accuracy. Two narrower descriptions will route better.

Update `skills.sh.json`: replace `"ralph"` with `"ralph-loop"` in the Implementation grouping, and add `"ralph-loop-setup"`.

### Working directory

Agreed convention:

```
.claude/loop/          (or .cursor/loop/)
├── active.md               active loop file, frontmatter + prompt body
├── <run-id>/
│   ├── context.md          static per-run context
│   ├── loop-state.md       mutable state, watched by the stall guard
│   ├── review-<TASK>.md
│   └── ux-review-<TASK>.md
└── archive/<run-id>/       completed runs
```

`<run-id>` is `{slug}-{YYYYMMDD-HHMMSS}` so repeat runs of the same epic do not collide.

**Drop the `.ralph-loop` pointer file.** It is the single largest source of fragility (root cause 1) and it is not needed. The hooks can resolve the base deterministically:

```bash
BASE="${CLAUDE_PROJECT_DIR:-$PWD}/.claude/loop"     # Claude hook
BASE="${CURSOR_PROJECT_DIR:-$PWD}/.cursor/loop"     # Cursor hook
```

Each agent's hook already knows which agent it is, so no discovery is required. This also removes the `--ralph-dir` flag and the four-branch resolution logic in `setup.prompt.md` step 4.

`.claude/` and `.cursor/` are already gitignored in most repos, so the gitignore step largely disappears. Setup should still verify and add `.claude/loop/` if the parent is not covered.

### Cross-agent compatibility

| Concern | Claude Code | Cursor |
| --- | --- | --- |
| Hook event | `Stop` | `stop` + `afterAgentResponse` |
| Continue signal | `{"decision":"block","reason":...}` | `{"followup_message":...}` |
| Promise detection | transcript parse | dedicated capture hook |
| Project root | `$CLAUDE_PROJECT_DIR` | `$CURSOR_PROJECT_DIR` |
| Plugin root | `$CLAUDE_PLUGIN_ROOT` | plugin-root variable |
| Iteration cap | `max_iterations` frontmatter | frontmatter **and** `loop_limit` |
| Sub-agent | Agent tool | Task tool |

The two stop scripts currently duplicate roughly 120 lines of near-identical logic and have already drifted (only one uses the project-dir variable). Extract the shared logic into `hooks/lib/ralph-common.sh` and keep two thin agent-specific wrappers that source it. Divergence is what produced defects 1 and 3.

Add a `hooks/lib/` shellcheck run to `scripts/validate-skills.sh` so this stays honest.

### Templates

Agreed: generic core plus an engineering preset.

```
skills/ralph-loop/assets/
├── loop.core.template.md            generic step machine, preset-agnostic
├── loop-state.core.template.md
├── context.core.template.md
└── presets/
    ├── engineering-delivery.md      current implement → review → validate → MR
    ├── ad-hoc.md                    single repeating prompt
    └── custom.md                    scaffold from interview answers
```

A preset declares only: step list, per-step instructions, advance conditions, budgets, and completion conditions. The core template owns the iteration protocol, the one-step rule, the state contract and the promise rules, so every preset inherits the guardrails.

`references/preset-authoring.md` documents how to write one, with a fully worked non-engineering example (a research or content loop reads well here, since it exercises the same machinery with none of the git or MR steps).

### Setup interview

`/ralph-loop-setup` should ask, via structured questions rather than prose:

1. **Preset** — engineering delivery, ad-hoc prompt, or custom steps.
2. **Target** — epic slug or ID for engineering; the prompt for ad-hoc; the step list for custom.
3. **Budgets** — max iterations (default 50), per-step fix budgets.
4. **Completion promise** — proposed default, confirmed by the user.
5. **Environment** — only for presets that need it, resolved per `references/environment-resolution.md`.

Then hand off to a shell script for the actual write, per the next section.

### Setup writes via script, not by hand

Move placeholder substitution out of the agent. `scripts/seed-ralph-loop.sh` takes resolved values as flags, validates them, and writes `active.md`, `context.md` and `loop-state.md` from the templates. The agent's job becomes resolving values and calling the script.

This eliminates the "unsubstituted placeholder" failure class entirely, matches how the official plugin works, and makes setup unit-testable.

---

## Part 4: Sequenced plan

### Phase 1: Make the loop run (fixes the reported bug)

1. Extract `hooks/lib/ralph-common.sh` with the shared parse, validate, stall-guard and iteration-increment logic.
2. Bound the frontmatter parse to the first block only (root cause 4).
3. Guard every command substitution: existence check before pipeline, `|| true` on greps, `set +e` fence around `jq` (root causes 1 and 3).
4. Adopt the official plugin's transcript parse in the Claude hook (root cause 3).
5. Resolve the base directory from the project-dir variables; delete pointer-file logic (root cause 1).
6. Set `loop_limit` to an explicit integer and absolute command paths in the Cursor config (root cause 2).
7. Add `session_id` to the frontmatter and the session check to the Claude hook.
8. Add the `stop_hook_active` check.
9. Add a shellcheck pass to `scripts/validate-skills.sh`.

**Done when:** a three-step ad-hoc loop runs to its promise unattended in Claude Code and in Cursor, and the same loop stops cleanly at `max_iterations` when the promise is withheld.

### Phase 2: Rename and split the command surface

1. `git mv skills/ralph skills/ralph-loop`; rewrite `name` and `description`.
2. Create `skills/ralph-loop-setup` from `prompts/setup.prompt.md`.
3. Reduce `skills/ralph-loop` to `start` / `status` / `cancel`, with `start` as the inferred default.
4. Update `skills.sh.json`, `README.md`, `CHANGELOG.md`, and every cross-reference in the other skills.
5. Update `evals/trigger-queries.json` for both new skills.

**Done when:** `scripts/validate-skills.sh` passes and no reference to `skills/ralph` remains.

### Phase 3: Working directory migration

1. Implement the `.{agent}/loop/` layout with `<run-id>` subdirectories and `archive/`.
2. Remove `.ralph-loop` and `--ralph-dir` from setup, prompts, references and hooks.
3. `cancel` archives the run directory rather than leaving it in place.
4. `status` reads `active.md` plus the current run directory.

**Done when:** a full run produces artefacts only under `.claude/loop/` or `.cursor/loop/`, and nothing at the project root.

### Phase 4: Script-backed seeding

1. Write `scripts/seed-ralph-loop.sh` with flag parsing, validation and template substitution.
2. Rewrite `ralph-loop-setup` to resolve values, then invoke the script.
3. Fail loudly on any remaining `{{...}}` in written output.

**Done when:** no placeholder can survive into a written file, and seeding is reproducible from the command line alone.

### Phase 5: Generalised templates

1. Split `loop.template.md` into the core template plus the engineering preset.
2. Add the ad-hoc and custom presets.
3. Write `references/preset-authoring.md` with a worked non-engineering example.
4. Add the preset question to the setup interview.
5. Extend `evals/evals.json` to cover at least one non-engineering preset end to end.

**Done when:** a non-engineering loop can be defined and run without touching the core template.

### Suggested sequencing

Phase 1 stands alone and can ship immediately. Phases 2 and 3 are best done together, since both are wide renames. Phase 4 must land before Phase 5, because generalised templates multiply the placeholder surface that Phase 4 makes safe. Phase 5 also depends on the Phase 1 frontmatter fix, since preset bodies will contain `---` separators and key-like lines.

---

## Part 5: Risks and open questions

**Risk: iteration cost.** One step per iteration with a fresh sub-agent per skill is the right design for context hygiene, but a 12-task epic runs roughly 60 to 80 iterations at default budgets. Worth measuring actual token cost on a real epic before recommending it as the default path.

**Risk: promise detection remains the weakest link.** Even after the Phase 1 fix, a Claude turn that ends purely on tool calls has no text to scan. Consider having the `done` step write a sentinel file that the hook checks first, and treat the transcript scan as the fallback rather than the primary. The Cursor side already has this via the `done` flag; Claude should match it.

**Risk: two stop hooks.** Your `start` prompt warns about the external `ralph-loop-plugin`, but only in prose. If Cursor exposes installed plugins to the hook, make it a hard check that refuses to start.

**Open question: does `cancel` need to stop a running loop mid-turn?** Today it removes the loop file, which only takes effect at the next stop-hook fire. If someone needs to abort a runaway loop immediately, that is a different mechanism and worth deciding now.

**Open question: `max_iterations` default of 50.** With the engineering preset a 12-task epic will exceed it. Either raise the default for that preset or derive it from task count, for example `tasks × 6 + 10`.
