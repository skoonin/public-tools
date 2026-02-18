# git-audit

Generate audit reports of GitHub PRs and direct commits with filtering by date range, file patterns, PR title/description patterns, and ticket numbers. Outputs as a list or CSV.

## Usage

```
git-audit [options]
```

## Options

| Flag | Description |
|------|-------------|
| `-o, --output` | Output format: `list` or `csv` (default: `list`) |
| `-s, --start-date` | Start date in YYYY-MM-DD format (default: 6 months ago) |
| `-e, --end-date` | End date in YYYY-MM-DD format (default: today) |
| `-sha` | Process specific commit SHAs |
| `-f, --file` | File containing a list of SHAs to process |
| `--file-pattern` | Regex to filter by filenames changed |
| `--title-patterns` | Regex patterns to match PR titles |
| `--description-patterns` | Regex patterns to match PR descriptions |
| `--app` | Application name to include in output |
| `--ticket-pattern` | Regex to extract ticket numbers (default: `[A-Z]+-\d+`) |

## Examples

```bash
# Audit last 6 months with default settings
git-audit

# Audit a specific date range and export to CSV
git-audit -s 2024-01-01 -e 2024-06-30 -o csv

# Filter PRs whose titles contain a Jira ticket pattern
git-audit --ticket-pattern "PROJ-[0-9]+"

# Audit specific commits
git-audit -sha abc123 def456

# Read SHAs from a file
git-audit -f shas.txt
```

## Notes

- Fetches PRs and direct commits concurrently (5 workers)
- Requires the repository to be on GitHub (uses `gh` CLI)

## Requirements

- `gh` (GitHub CLI) authenticated
- `GitPython` Python package (installed via `make install`)
