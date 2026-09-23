# tfplan-all

Run `terraform init` and `terraform plan` across all subdirectories containing `.tf` files. Use `--tofu` to run `tofu` (OpenTofu) instead; this also plans directories with `.tofu` files. Supports parallel execution and optional output file saving.

## Usage

```
tfplan-all [TARGET_DIR] [FILTER_PATTERN] [OPTIONS]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `TARGET_DIR` | Root directory to search (default: current directory) |
| `FILTER_PATTERN` | Glob or regex pattern to filter directory paths |

## Options

| Flag | Description |
|------|-------------|
| `-j, --jobs N` | Parallel jobs to run (1-32, default: 4) |
| `-o, --output-dir DIR` | Directory to save plan output files |
| `-n, --dry-run` | List matching directories without running |
| `-t, --tofu` | Use `tofu` (OpenTofu) instead of `terraform` |
| `-q, --quiet` | Suppress progress output |
| `-V, --version` | Show version |

## Examples

```bash
# Plan all Terraform directories from current path
tfplan-all

# Plan a specific subtree
tfplan-all ~/infra/terraform

# Filter to only prod directories
tfplan-all ~/infra "prod"

# Run 8 jobs in parallel and save output
tfplan-all -j 8 -o /tmp/plans

# List directories that would be planned without running
tfplan-all --dry-run

# Use OpenTofu
tfplan-all --tofu
```

## Environment

| Variable | Description |
|----------|-------------|
| `TFPLAN_ALL_BIN` | Binary to run: `terraform` (default) or `tofu`. Other values are an error. `--tofu` overrides a valid value. |

## Notes

- Timeout: 5 minutes for `init`, 10 minutes for `plan`
- Plan files are saved as `path-with-dashes.tfplan.txt`
- Colored output; disable with `NO_COLOR=1` environment variable
- Handles `Ctrl+C` gracefully, canceling in-progress plans
- With `tofu`, directories with `.tofu` files are also planned. With `terraform`, only `.tf` files are scanned, because Terraform cannot read `.tofu` files.
- For a repository that uses both tools, do one run per tool and point each run at its directories.
- `tofu init` can update `.terraform.lock.hcl` in a directory that Terraform initialized, because OpenTofu gets providers from its own registry. Check `git diff` before you commit the lock file.

## Requirements

- `terraform` in PATH, or `tofu` in PATH when you use `--tofu` or `TFPLAN_ALL_BIN=tofu`
