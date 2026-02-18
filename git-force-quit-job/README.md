# git-force-quit-job

Force-cancel a GitHub Actions workflow run by URL. Useful when a run is stuck and the normal cancel button is unresponsive.

## Usage

```
git-force-quit-job <RUN_URL>
```

## Arguments

| Argument | Description |
|----------|-------------|
| `RUN_URL` | Full GitHub Actions run URL (required) |

## Example

```bash
git-force-quit-job https://github.com/my-org/my-repo/actions/runs/12345678
```

## Requirements

- `gh` (GitHub CLI) authenticated with write access to the repository
