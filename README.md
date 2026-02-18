# public-tools

[![CI](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml/badge.svg)](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml)

A collection of CLI tools I've written for myself that have been useful. Yes, there was help from the robots here, mostly Claude.

## Tools

| Tool | Description | Language | Version | Released |
|------|-------------|----------|---------|----------|
| [`asm`](asm/README.md) | AWS Secrets Manager CLI.<br>Get, create, update, delete, and search secrets.<br>Supports key/value pairs, files, TLS certs, and binary data. | Python | v1.0.0 | 2026-02-18 |
| [`aws-secret-replication-check`](aws-secret-replication-check/README.md) | Check Secrets Manager replication status.<br>Lists all secrets in a region with their cross-region replication state. | Python | v1.0.0 | 2026-02-18 |
| [`brew-python`](brew-python/) | Manage Homebrew Python symlinks.<br>Lists available versions, shows current status, switches between installed versions. | Bash | v1.0.0 | 2026-02-18 |
| [`ec2-search`](ec2-search/) | Audit EC2 instances across AWS accounts.<br>Displays Profile, Instance ID, Type, AZ, State, and tags.<br>Supports multiple AWS profiles and custom tag filtering. | Python | v1.0.0 | 2026-02-18 |
| [`ec2-state`](ec2-state/README.md) | View and manage EC2 instance state.<br>Stop, start, or terminate instances by ID.<br>Auto-discovers region across all AWS regions. | Python | v1.0.0 | 2026-02-18 |
| [`fcd`](fcd/) | Fuzzy directory finder (interactive cd).<br>Searches directories by name with interactive selection.<br>Configurable exclusions, depth control, and k8s context switching. | Bash | v1.0.0 | 2026-02-18 |
| [`gh-cleanup-runners`](gh-cleanup-runners/) | Clean up GitHub Actions self-hosted runners.<br>Identifies and removes offline runners at org or repo level. | Bash | v1.0.0 | 2026-02-18 |
| [`gh-runner-audit`](gh-runner-audit/README.md) | Audit GitHub Actions runner usage across an org.<br>Lists repos with workflow status, runner groups, and runner counts. | Python | v1.0.0 | 2026-02-18 |
| [`gh-search`](gh-search/) | Search GitHub for code and repositories.<br>Displays matching repos with option to clone and open in VS Code. | Python | v1.0.0 | 2026-02-18 |
| [`git-audit`](git-audit/README.md) | Audit GitHub PRs and direct commits.<br>Reports filtered by date, file patterns, PR titles, and ticket numbers.<br>Outputs as list or CSV. | Python | v1.0.0 | 2026-02-18 |
| [`git-cleanup`](git-cleanup/) | Manage GitHub Actions runs and git branches.<br>Delete all workflow runs for a branch or delete local branches except main/master. | Python | v1.0.0 | 2026-02-18 |
| [`git-copy-branch`](git-copy-branch/) | Copy file changes between git branches.<br>Copies modified/added/deleted files from origin to destination branch.<br>Auto-commits deleted files. | Python | v1.0.0 | 2026-02-18 |
| [`git-force-quit-job`](git-force-quit-job/README.md) | Force-cancel a stuck GitHub Actions run.<br>Parses the run URL and issues a force-cancel via `gh api`. | Bash | v1.0.0 | 2026-02-18 |
| [`git-update-branches`](git-update-branches/) | Batch update git repositories.<br>Iterates through a directory of repos and updates the default branch.<br>Preserves state (stash, current branch) and restores after update. | Bash | v1.0.1 | 2026-02-18 |
| [`github-delete-pr-comments`](github-delete-pr-comments/README.md) | Delete all comments on a pull request.<br>Removes comments by PR URL; reads credentials from `~/.git-credentials`. | Python | v1.0.0 | 2026-02-18 |
| [`k8s-label-search`](k8s-label-search/) | Search Kubernetes resources by labels and annotations.<br>Match by key, value, or key=value across multiple clusters.<br>Supports JSON and matrix output formats. | Python | v1.0.0 | 2026-02-18 |
| [`ktail`](ktail/README.md) | Tail Kubernetes logs with filtering and multi-pod support.<br>Streams logs from all matching pods simultaneously.<br>Supports colored output, JSON format, and include/exclude regex. | Bash | v1.0.0 | 2026-02-18 |
| [`ktx`](ktx/README.md) | Fuzzy search and switch Kubernetes contexts.<br>Numbered menu when multiple contexts match; optionally switches namespace. | Bash | v1.0.0 | 2026-02-18 |
| [`merge-yaml`](merge-yaml/README.md) | Deep-merge two YAML files.<br>Second file's values override the first.<br>Optionally annotates changed lines with a comment. | Python | v1.0.0 | 2026-02-18 |
| [`open-github-repo`](open-github-repo/README.md) | Search and open a GitHub repository in browser.<br>Opens current repo without arguments; supports org-scoped search. | Python | v1.0.0 | 2026-02-18 |
| [`sort-manifests`](sort-manifests/README.md) | Sort Kubernetes manifests by kind and name.<br>Sorts multi-document YAML and writes output with a `-sorted` suffix. | Python | v1.0.0 | 2026-02-18 |
| [`sort-yaml-key`](sort-yaml-key/README.md) | Sort a YAML list by a specified key.<br>Reorders each block so the sort key appears first. | Python | v1.0.0 | 2026-02-18 |
| [`testpod`](testpod/README.md) | Deploy a netshoot debug pod for network troubleshooting.<br>Creates a `nicolaka/netshoot` pod with optional interactive shell.<br>Supports easy cleanup with `-d` flag. | Python | v1.0.0 | 2026-02-18 |
| [`tf-sort`](tf-sort/) | Sort Terraform resource definitions alphabetically.<br>Organizes Terraform files for better readability and git diffs.<br>Preserves comments and formatting. | Bash | v1.0.0 | 2026-02-18 |
| [`tfdel`](tfdel/README.md) | Delete `.terraform` directories and lock files.<br>Recursively removes Terraform caches and reports disk space reclaimed. | Python | v1.0.0 | 2026-02-18 |
| [`tfplan-all`](tfplan-all/README.md) | Run `terraform plan` across all Terraform directories.<br>Parallel init+plan with filtering, output saving, and graceful cancellation. | Python | v1.0.0 | 2026-02-18 |

## Installation

### Quick Start

```bash
make install      # Install Python dependencies
make link         # Symlink tools to ~/.local/bin
```

Ensure `~/.local/bin` is in your PATH, or specify a different location:

```bash
make link INSTALL_DIR=~/bin
```

### Requirements

**Python**: 3.10 or later (for type hints and modern syntax)

**CLI tools** (verified with `make check-deps`):
- `git` - Required for most tools
- `gh` (GitHub CLI) - Required for git-cleanup, git-audit, gh-cleanup-runners, gh-runner-audit, gh-search, git-force-quit-job, open-github-repo, github-delete-pr-comments
- `aws` (AWS CLI) - Required for ec2-search, ec2-state, asm, aws-secret-replication-check
- `kubectl` - Required for k8s-label-search, ktail, ktx, testpod
- `kubectx`, `kubens` - Required for ktx
- `terraform` - Required for tfplan-all
- `jq` - Required for gh-cleanup-runners

**Python packages** (installed via `make install`):
- `typer` - CLI framework
- `GitPython` - Git operations for git-copy-branch, git-audit
- `tabulate` - Table formatting
- `requests` - HTTP client for gh-search, github-delete-pr-comments
- `boto3` - AWS SDK for asm, aws-secret-replication-check
- `PyYAML` - YAML parsing for merge-yaml, sort-manifests, sort-yaml-key
- `PyGithub` - GitHub API for open-github-repo

Run `make check-deps` to verify required CLI tools are installed.

### Uninstall

```bash
make unlink       # Remove symlinks
make uninstall    # Remove Python dependencies
```

## Development

```bash
make install-dev  # Install dependencies + pre-commit hooks
make lint         # Run all linters
make clean        # Clean caches and bytecode
```

## Releases

Each tool is versioned independently using tags in the format `<tool-name>/v<version>`.

To release a new version of a tool:

```bash
git tag brew-python/v1.0.0
git push origin brew-python/v1.0.0
```

This triggers a GitHub release with the tool files attached.
