# public-tools

[![CI](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml/badge.svg)](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml)

A collection of CLI tools I've written for myself that have been useful.

## Tools

### System & Package Management

- **`brew-python`** - Manage Homebrew Python symlinks
  - Lists available Python versions, shows current status, switches between installed versions
  - Usage: `brew-python [version]` to switch, `brew-python --list`, `brew-python --status`

### Cloud & Infrastructure

- **`ec2-search`** - Audit EC2 instances across AWS accounts
  - Finds all EC2 instances and displays Profile, Instance ID, Type, AZ, State, and tags
  - Supports multiple AWS profiles and custom tag filtering

- **`k8s-label-search`** - Search Kubernetes resources by labels and annotations
  - Find resources across clusters by matching label/annotation keys, values, or key=value pairs
  - Supports multiple contexts and JSON/matrix output formats
  - Requires: `kubectl`

- **`tf-sort`** - Sort Terraform resource definitions alphabetically
  - Organizes Terraform files for better readability and git diffs
  - Preserves comments and formatting

### Git & GitHub

- **`git-cleanup`** ⚠️ **[DESTRUCTIVE]** - Manage GitHub Actions runs and git branches
  - Delete all workflow runs for a specific branch
  - Delete local branches except main/master
  - Requires: `gh` (GitHub CLI)

- **`git-copy-branch`** ⚠️ **[MODIFIES GIT]** - Copy file changes between branches
  - Copies modified/added/deleted files from origin branch to destination branch
  - Auto-commits deleted files (stages additions/modifications)
  - Requires: GitPython

- **`git-update-branches`** - Batch update git repositories
  - Iterates through directory of repos and updates default branch
  - Preserves state (stash, current branch) and restores after update
  - Usage: `git-update-branches-in-dir [-v] [-f] [-d DIR]`

- **`gh-cleanup-runners`** - Clean up GitHub Actions self-hosted runners
  - Identifies and removes stale/offline runners
  - Requires: `gh` (GitHub CLI)

- **`gh-search`** - Search GitHub for code and repositories
  - Searches GitHub for strings and displays matching repos
  - Can clone repos and open VS Code workspace with results

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
- `gh` (GitHub CLI) - Required for git-cleanup, gh-cleanup-runners, gh-search
- `aws` (AWS CLI) - Required for ec2-search
- `kubectl` - Required for k8s-label-search

**Python packages** (installed via `make install`):
- `typer` - CLI framework for git-cleanup
- `GitPython` - Git operations for git-copy-branch
- `tabulate` - Table formatting for ec2-search
- `requests` - HTTP client for gh-search

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
