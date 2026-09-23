#!/usr/bin/env bash
#
# tf-sort-smoke.sh - Smoke test for tf-sort
#
# Builds test files in a temp directory, runs tf-sort on them, and exits
# non-zero on the first failed check. Requires GNU Awk.
#
set -euo pipefail

TF_SORT="$(cd "$(dirname "$0")/.." && pwd)/tf-sort/tf-sort"
WORK_DIR="$(mktemp -d)"
: > "$WORK_DIR/stderr.log"

# On any failure, including a tf-sort crash that set -e stops on, show its stderr
cleanup() {
    local rc=$?
    if (( rc != 0 )); then
        echo "--- tf-sort stderr ---" >&2
        cat "$WORK_DIR/stderr.log" >&2
    fi
    rm -rf "$WORK_DIR"
}
trap cleanup EXIT
cd "$WORK_DIR"

fail() {
    echo "FAIL: $*" >&2
    exit 1
}

# Top-level block openers must appear in sorted order
assert_sorted() {
    grep '^[a-z]' "$1" > openers.got || fail "$1 has no top-level blocks"
    LC_ALL=C sort -f openers.got > openers.want
    if ! diff openers.got openers.want > /dev/null; then
        fail "$1 blocks not sorted: $(tr '\n' '|' < openers.got)"
    fi
}

# Non-empty lines must be the same before and after, ignoring order
assert_same_lines() {
    grep -v '^$' "$1" | LC_ALL=C sort > lines.before
    grep -v '^$' "$2" | LC_ALL=C sort > lines.after
    if ! diff lines.before lines.after > /dev/null; then
        fail "$2 lines changed, not only reordered"
    fi
}

write_unsorted() {
    cat > "$1" <<'HCL'
variable "b" {}

variable "a" {}
HCL
}

# Case 1: every argument is processed
mkdir d1 d2
write_unsorted d1/main.tf
write_unsorted d2/main.tf
"$TF_SORT" d1 d2 2>> stderr.log
assert_sorted d1/main.tf
assert_sorted d2/main.tf
echo "ok: multiple arguments"

# Case 2: language, ephemeral, and action blocks sort as their own blocks;
# a nested block named language stays inside its resource
mkdir blocks
cat > blocks/main.tf <<'HCL'
resource "zzz" "a" {
  x = 1
  language {
    code = "en"
  }
  settings {
    language {
      code = "en"
    }
  }
}

language {
  compatible_with {
    opentofu = ">= 1.12"
  }
}

ephemeral "random_password" "db" {
  length = 16
}

action "aws_lambda_invoke" "run" {
  config {
    function_name = "f"
  }
}

terraform {
  required_version = ">= 1.0"
}

resource "aaa" "b" {
  y = 2
}
HCL
cp blocks/main.tf blocks.orig
"$TF_SORT" blocks 2>> stderr.log
assert_sorted blocks/main.tf
assert_same_lines blocks.orig blocks/main.tf
awk '/^resource "zzz"/,/^}/' blocks.orig > zzz.want
awk '/^resource "zzz"/,/^}/' blocks/main.tf > zzz.got
diff zzz.want zzz.got > /dev/null || fail "nested language block moved out of resource \"zzz\""
echo "ok: language, ephemeral, action blocks"

# Case 3: .tofu files are processed, in directory and file mode
mkdir tofu
write_unsorted tofu/main.tofu
write_unsorted extra.tofu
dry_out="$("$TF_SORT" --dry-run tofu extra.tofu 2>> stderr.log)"
grep -qx 'tofu/main.tofu' <<< "$dry_out" || fail "--dry-run does not list tofu/main.tofu"
grep -qx 'extra.tofu' <<< "$dry_out" || fail "--dry-run does not list extra.tofu"
"$TF_SORT" tofu extra.tofu 2>> stderr.log
assert_sorted tofu/main.tofu
assert_sorted extra.tofu
[[ -f tofu/main.tofu.bak ]] || fail "tofu/main.tofu.bak not created"
echo "ok: .tofu files"

# Case 4: directories named like .tf or .tofu files are not processed
mkdir -p decoy/x.tf decoy/y.tofu
write_unsorted decoy/real.tf
dry_out="$("$TF_SORT" --dry-run decoy 2>> stderr.log)"
grep -qx 'decoy/real.tf' <<< "$dry_out" || fail "--dry-run does not list decoy/real.tf"
if grep -qE '(x\.tf|y\.tofu)$' <<< "$dry_out"; then
    fail "--dry-run lists a directory: $dry_out"
fi
"$TF_SORT" decoy 2>> stderr.log
[[ -d decoy/x.tf && -d decoy/y.tofu ]] || fail "decoy directory was replaced by a file"
assert_sorted decoy/real.tf
echo "ok: directories named x.tf and y.tofu"

# Case 5: block state does not carry over from one file to the next
mkdir leak
printf 'variable "m" {}\n' > leak/first.tf
printf '# header\n\nvariable "z" {}\n\nvariable "m" {}\n\nvariable "a" {}\n' > leak/second.tf
cp leak/second.tf leak.orig
"$TF_SORT" leak/first.tf leak/second.tf 2>> stderr.log
assert_sorted leak/second.tf
assert_same_lines leak.orig leak/second.tf
echo "ok: no state carried between files"

echo "All tf-sort smoke tests passed"
