# gh-runner-audit

Audit GitHub Actions runner usage across an organization. Lists repositories with their workflow status, runner groups, runner counts, and active runners.

## Usage

```
gh-runner-audit --org ORG_NAME [options]
```

## Options

| Flag | Description |
|------|-------------|
| `--org` | GitHub organization name (required) |
| `--include-archived` | Include archived repositories |
| `--skip-repo-runners` | Skip per-repo runner counts for faster output |

## Examples

```bash
# Audit all runners in an org
gh-runner-audit --org my-org

# Include archived repos
gh-runner-audit --org my-org --include-archived

# Fast mode - skip per-repo runner detail
gh-runner-audit --org my-org --skip-repo-runners
```

## Output

Tabular output showing per-repository:
- Repository name
- Workflow count and status
- Runner groups assigned
- Runner counts (org-level and repo-level)

## Requirements

- `gh` (GitHub CLI) authenticated with appropriate permissions
- Organization admin access to view runner details
