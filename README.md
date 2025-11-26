# public-tools

[![CI](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml/badge.svg)](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml)

A collection of some tools I've written for myself that have been useful.

- `brew-python`
  - Manages Homebrew Python symlinks. Lists available Python versions, shows current status, and switches between installed Homebrew Python versions.
  - Usage: `brew-python [version]` to switch, `brew-python --list` to show available, `brew-python --status` to show current
- `ec2-search`
  - Helpful to audit EC2 instances. Finds all EC2 instances and prints out Profile, Instance ID, Instance Type, Availability Zone, State and your desired tags or all tags.
- `gh-search`
  -  Searches GitHub for a given string and prints out the repos that contain it. Also gives you links and can clone the code and open a VS code session with all repos.
- `git-update-branches`
  - Iterates through a directory of git repos and pulls and prunes the default branch. It saves your repo state (stash, branch) and resets it back to where you left it once its done.
- `gdir`
  - Searches through a dir (for me it's ~/git) for a string and changes to that directory.
  - Takes a second string for a sub directory.
  - Takes the `-c` flag. and if the dir ends with -infra, it will try and change k8s context (a use case for myself)
  - Takes the `-n` flag to specify namespace when changing contexts

  - To work properly, source this in your shell profile (e.g. .bashrc, .zshrc, etc)
    - `alias gd ='. <path>/gdir'`
  - Example: `gd services-dev redis -n monitoring`
    - first search for `services-dev`, if it finds multiples it will ask you.
    - then searches for a subdir that contains `redis`, if it finds multiples it will ask you.
    - if `-c` is passed, then if the primary dir ends with -infra, it will try and change k8s context
    - then if it changes context, it will also use the namespace `monitoring`.

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

- **CLI tools**: `git`, `gh` (GitHub CLI), `aws` (AWS CLI)
- **Python packages**: `tabulate`, `requests` (installed via `make install`)

Run `make check-deps` to verify CLI tools are installed.

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
