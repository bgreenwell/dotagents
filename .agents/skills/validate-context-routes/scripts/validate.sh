#!/usr/bin/env bash

set -euo pipefail

project_root="${1:-.}"
agents_file="${project_root%/}/AGENTS.md"

if [[ ! -f "$agents_file" ]]; then
    printf 'ERROR: root AGENTS.md not found: %s\n' "$agents_file" >&2
    exit 1
fi

routes="$(
    LC_ALL=C awk '
        {
            line = $0
            while (match(line, /`[^`]+`/)) {
                print substr(line, RSTART + 1, RLENGTH - 2)
                line = substr(line, RSTART + RLENGTH)
            }
        }
    ' "$agents_file" \
        | grep -E '^(\.?[A-Za-z0-9_-]+/)*[A-Za-z0-9_.-]+/?$' \
        | grep -E '(/|\.md$)' \
        | sort -u \
        || true
)"

if [[ -z "$routes" ]]; then
    printf 'Context routes valid (0 literal project paths checked).\n'
    exit 0
fi

checked=0
missing=0

while IFS= read -r route; do
    [[ -z "$route" ]] && continue
    checked=$((checked + 1))

    if [[ ! -e "${project_root%/}/$route" ]]; then
        printf 'MISSING: %s\n' "$route" >&2
        missing=$((missing + 1))
    fi
done <<< "$routes"

if (( missing > 0 )); then
    printf 'Context route validation failed (%d of %d missing).\n' "$missing" "$checked" >&2
    exit 1
fi

printf 'Context routes valid (%d checked).\n' "$checked"
