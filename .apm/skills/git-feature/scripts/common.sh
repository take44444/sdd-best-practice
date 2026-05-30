#!/usr/bin/env bash
# Common functions and variables for all scripts

# Escape a string for safe embedding in a JSON value (fallback when jq is unavailable).
# Handles backslash, double-quote, and JSON-required control character escapes (RFC 8259).
json_escape() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\t'/\\t}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\b'/\\b}"
    s="${s//$'\f'/\\f}"
    # Escape any remaining U+0001-U+001F control characters as \uXXXX.
    # (U+0000/NUL cannot appear in bash strings and is excluded.)
    # LC_ALL=C ensures ${#s} counts bytes and ${s:$i:1} yields single bytes,
    # so multi-byte UTF-8 sequences (first byte >= 0xC0) pass through intact.
    local LC_ALL=C
    local i char code
    for (( i=0; i<${#s}; i++ )); do
        char="${s:$i:1}"
        printf -v code '%d' "'$char" 2>/dev/null || code=256
        if (( code >= 1 && code <= 31 )); then
            printf '\\u%04x' "$code"
        else
            printf '%s' "$char"
        fi
    done
}

# Find repository root by searching upward for .apm directory
find_apm_root() {
    local dir="${1:-$(pwd)}"
    # Normalize to absolute path to prevent infinite loop with relative paths
    # Use -- to handle paths starting with - (e.g., -P, -L)
    dir="$(cd -- "$dir" 2>/dev/null && pwd)" || return 1
    local prev_dir=""
    while true; do
        if [ -d "$dir/.apm" ]; then
            echo "$dir"
            return 0
        fi
        # Stop if we've reached filesystem root or dirname stops changing
        if [ "$dir" = "/" ] || [ "$dir" = "$prev_dir" ]; then
            break
        fi
        prev_dir="$dir"
        dir="$(dirname "$dir")"
    done
    return 1
}

# Get repository root, prioritizing .apm directory over git
# This prevents using a parent git repo when apm is initialized in a subdirectory
get_repo_root() {
    # First, look for .apm directory (apm's own marker)
    local apm_root
    if apm_root=$(find_apm_root); then
        echo "$apm_root"
        return
    fi

    # Fallback to git if no .apm found
    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        git rev-parse --show-toplevel
        return
    fi

    # Final fallback to script location for non-git repos
    local script_dir="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    (cd "$script_dir/../../.." && pwd)
}

# Check if we have git available at the apm root level
# Returns true only if git is installed and the repo root is inside a git work tree
# Handles both regular repos (.git directory) and worktrees/submodules (.git file)
has_git() {
    # First check if git command is available (before calling get_repo_root which may use git)
    command -v git >/dev/null 2>&1 || return 1
    local repo_root=$(get_repo_root)
    # Check if .git exists (directory or file for worktrees/submodules)
    [ -e "$repo_root/.git" ] || return 1
    # Verify it's actually a valid git work tree
    git -C "$repo_root" rev-parse --is-inside-work-tree >/dev/null 2>&1
}