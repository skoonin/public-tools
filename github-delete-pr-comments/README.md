# github-delete-pr-comments

Delete all comments on a GitHub pull request. Useful for clearing bot comments or cleaning up noisy PR threads before merging.

## Usage

```
github-delete-pr-comments <PR_URL>
```

## Arguments

| Argument | Description |
|----------|-------------|
| `PR_URL` | Full GitHub pull request URL (required) |

## Example

```bash
github-delete-pr-comments https://github.com/my-org/my-repo/pull/42
```

## Notes

- Reads credentials from `~/.git-credentials`
- Supports both github.com and GitHub Enterprise (on-premises) instances

## Requirements

- `~/.git-credentials` with a valid GitHub token
- `requests` Python package (installed via `make install`)
- Token requires `repo` scope to delete comments
