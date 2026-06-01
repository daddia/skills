#!/usr/bin/env bash
# Validate Agent Skills in this repo (frontmatter + name/folder match).
# Usage: ./scripts/validate-skills.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0
shopt -s nullglob

for skill_md in skills/*/SKILL.md; do
  skill_dir="${skill_md%/SKILL.md}"
  skill_name="${skill_dir#skills/}"

  name="$(grep -E '^name:' "$skill_md" | head -1 | sed 's/^name:[[:space:]]*//' | tr -d '"')"
  if [[ -z "$name" ]]; then
    echo "FAIL $skill_name: missing name"
    fail=1
    continue
  fi
  if [[ "$name" != "$skill_name" ]]; then
    echo "FAIL $skill_name: name '$name' must match directory"
    fail=1
    continue
  fi

  if ! grep -q '^description:' "$skill_md"; then
    echo "FAIL $skill_name: missing description"
    fail=1
    continue
  fi

  desc_chars="$(awk '
    /^description:/ { capture=1; sub(/^description:[[:space:]]*/, ""); if (length($0)) total += length($0); next }
    capture && /^[a-z-]+:/ { exit }
    capture { gsub(/^[[:space:]]+/, ""); total += length($0) + 1 }
    END { print total+0 }
  ' "$skill_md" | tr -d '\n')"
  if [[ "${desc_chars:-0}" -gt 1024 ]]; then
    echo "FAIL $skill_name: description ~$desc_chars chars (max 1024)"
    fail=1
    continue
  fi

  echo "ok: $skill_name"
done

if [[ -x skills/backlog/scripts/check-epic-paths.sh ]] && [[ -f skills/backlog/examples/backlog.md ]]; then
  skills/backlog/scripts/check-epic-paths.sh skills/backlog/examples/backlog.md || fail=1
fi

if [[ -f skills.sh.json ]]; then
  python3 -c "import json; json.load(open('skills.sh.json'))" 2>/dev/null || {
    echo "FAIL: skills.sh.json invalid JSON"
    fail=1
  }
fi

for manifest in .claude-plugin/plugin.json .cursor-plugin/plugin.json; do
  if [[ -f "$manifest" ]]; then
    python3 -c "import json; json.load(open('$manifest'))" 2>/dev/null || {
      echo "FAIL: $manifest invalid JSON"
      fail=1
    }
  fi
done

exit "$fail"
