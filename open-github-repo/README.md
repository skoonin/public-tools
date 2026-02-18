# open-github-repo

Search for a GitHub repository by name and open it in your default browser. If run without arguments inside a git repository, opens the current repo.

## Usage

```
open-github-repo [SEARCH] [-o ORG]
```

## Arguments

| Argument | Description |
|----------|-------------|
| `SEARCH` | Repository name or search term (optional) |

## Options

| Flag | Description |
|------|-------------|
| `-o, --organization ORG` | Limit search to a GitHub organization |

## Examples

```bash
# Open the current git repository in browser
open-github-repo

# Search for a repo and open it
open-github-repo my-tool

# Search within a specific org
open-github-repo my-tool -o my-org
```

## Notes

- Uses `gh` CLI to retrieve the authentication token
- If multiple repos match, displays a selection menu

## Requirements

- `gh` (GitHub CLI) authenticated
- `PyGithub` Python package (installed via `make install`)
