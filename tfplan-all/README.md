# tfplan-all

Run `terraform init` and `terraform plan` across all subdirectories containing `.tf` files. Supports parallel execution and optional output file saving.

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
```

## Notes

- Timeout: 5 minutes for `init`, 10 minutes for `plan`
- Plan files are saved as `path-with-dashes.tfplan.txt`
- Colored output; disable with `NO_COLOR=1` environment variable
- Handles `Ctrl+C` gracefully, canceling in-progress plans

## Requirements

- `terraform` in PATH
