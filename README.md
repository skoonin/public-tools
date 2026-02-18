# public-tools

[![CI](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml/badge.svg)](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml)

A collection of CLI tools I've written for myself that have been useful. Yes, there was help from the robots here, mostly Claude.

## Tools

### System & Package Management

- **`brew-python`** - Manage Homebrew Python symlinks
  - Lists available Python versions, shows current status, switches between installed versions
  - Usage: `brew-python [version]` to switch, `brew-python --list`, `brew-python --status`

### AWS & Cloud

- **`asm`** - AWS Secrets Manager CLI
  - Get, create, update, delete, and search secrets; supports key/value pairs, files, TLS certs, and binary data
  - Usage: `asm <command> [options]` — commands: `get`, `create`, `update`, `delete`, `search`, `list`

- **`aws-secret-replication-check`** - Check Secrets Manager replication status
  - Lists all secrets in a region with their cross-region replication state
  - Usage: `aws-secret-replication-check check-replication -r REGION -p PROFILE`

- **`ec2-search`** - Audit EC2 instances across AWS accounts
  - Finds all EC2 instances and displays Profile, Instance ID, Type, AZ, State, and tags
  - Supports multiple AWS profiles and custom tag filtering

- **`ec2-state`** - View and manage EC2 instance state
  - Stop, start, or terminate instances by ID; auto-discovers region across all regions
  - Usage: `ec2-state -p PROFILE -i INSTANCE_IDS [--stop|--run|--terminate]`

### Kubernetes

- **`k8s-label-search`** - Search Kubernetes resources by labels and annotations
  - Find resources across clusters by matching label/annotation keys, values, or key=value pairs
  - Supports multiple contexts and JSON/matrix output formats
  - Requires: `kubectl`

- **`ktail`** - Tail Kubernetes logs with filtering and multi-pod support
  - Streams logs from all matching pods simultaneously with include/exclude regex filtering
  - Supports colored output, JSON format, and multiple targeting options
  - Requires: `kubectl`

- **`ktx`** - Fuzzy search and switch Kubernetes contexts
  - Displays a numbered menu when multiple contexts match; optionally switches namespace
  - Usage: `ktx [SEARCH] [FILTER] [-n NAMESPACE]`
  - Requires: `kubectx`, `kubens`

- **`testpod`** - Deploy a netshoot debug pod for network troubleshooting
  - Creates a `nicolaka/netshoot` pod with optional interactive shell; supports easy cleanup
  - Usage: `testpod [-ns NAMESPACE] [-c CONTEXT] [-s] [-d]`
  - Requires: `kubectl`

- **`sort-manifests`** - Sort Kubernetes manifests by kind and name
  - Sorts multi-document YAML manifests and writes output with a `-sorted` suffix
  - Usage: `sort-manifests FILE1.yaml [FILE2.yaml ...]`

### Terraform

- **`tf-sort`** - Sort Terraform resource definitions alphabetically
  - Organizes Terraform files for better readability and git diffs
  - Preserves comments and formatting

- **`tfdel`** - Delete `.terraform` directories and lock files
  - Recursively removes Terraform caches; reports disk space reclaimed
  - Usage: `tfdel [PATH]`

- **`tfplan-all`** - Run `terraform plan` across all Terraform directories
  - Parallel init+plan with filtering, output saving, and graceful cancellation
  - Usage: `tfplan-all [TARGET_DIR] [FILTER_PATTERN] [-j JOBS] [-o OUTPUT_DIR]`

### Git & GitHub

- **`git-audit`** - Audit GitHub PRs and direct commits
  - Generates reports filtered by date, file patterns, PR titles, and ticket numbers
  - Outputs as list or CSV; requires `gh` CLI

- **`git-cleanup`** ⚠️ **[DESTRUCTIVE]** - Manage GitHub Actions runs and git branches
  - Delete all workflow runs for a specific branch
  - Delete local branches except main/master
  - Requires: `gh` (GitHub CLI)

- **`git-copy-branch`** ⚠️ **[MODIFIES GIT]** - Copy file changes between branches
  - Copies modified/added/deleted files from origin branch to destination branch
  - Auto-commits deleted files (stages additions/modifications)
  - Requires: GitPython

- **`git-force-quit-job`** - Force-cancel a stuck GitHub Actions run
  - Parses the run URL and issues a force-cancel via `gh api`
  - Usage: `git-force-quit-job <RUN_URL>`
  - Requires: `gh` (GitHub CLI)

- **`git-update-branches`** - Batch update git repositories
  - Iterates through directory of repos and updates default branch
  - Preserves state (stash, current branch) and restores after update
  - Usage: `git-update-branches-in-dir [-v] [-f] [-d DIR]`

- **`gh-cleanup-runners`** - Clean up GitHub Actions self-hosted runners
  - Identifies and removes offline runners at org or repo level
  - Requires: `gh` (GitHub CLI), `jq`

- **`gh-runner-audit`** - Audit GitHub Actions runner usage across an org
  - Lists repos with workflow status, runner groups, and runner counts
  - Usage: `gh-runner-audit --org ORG_NAME`
  - Requires: `gh` (GitHub CLI)

- **`gh-search`** - Search GitHub for code and repositories
  - Searches GitHub for strings and displays matching repos
  - Can clone repos and open VS Code workspace with results

- **`github-delete-pr-comments`** - Delete all comments on a pull request
  - Removes all comments from a PR by URL; reads credentials from `~/.git-credentials`
  - Usage: `github-delete-pr-comments <PR_URL>`

- **`open-github-repo`** - Search and open a GitHub repository in browser
  - Opens current repo if run without arguments; supports org-scoped search
  - Usage: `open-github-repo [SEARCH] [-o ORG]`
  - Requires: `gh` (GitHub CLI)

### YAML & Config

- **`merge-yaml`** - Deep-merge two YAML files
  - Second file's values override the first; optionally annotates changed lines with a comment
  - Usage: `merge-yaml FILE1 FILE2 [OUTPUT] [--comment TEXT]`

- **`sort-yaml-key`** - Sort a YAML list by a specified key
  - Sorts list items by key and reorders each block so the key appears first
  - Usage: `sort-yaml-key -f FILENAME -k KEY`

### Navigation

- **`fcd`** - Fuzzy directory finder (interactive cd)
  - Searches directories by name with interactive selection
  - Configurable exclusions, depth control, context switching for k8s
  - Usage: Source in shell profile: `. /path/to/fcd/fcd <search> [subsearch]`
  - Example: `fcd services redis` - finds directories matching both terms

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
