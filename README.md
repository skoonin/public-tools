# public-tools

[![CI](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml/badge.svg)](https://github.com/skoonin/public-tools/actions/workflows/ci.yaml)

A collection of some tools I've written for myself that have been useful.

- `brew-python`
  - Manages Homebrew Python symlinks. Lists available Python versions, shows current status, and switches between installed Homebrew Python versions.
  - Usage: `brew-python [version]` to switch, `brew-python --list` to show available, `brew-python --status` to show current
- `dotfiles`
  - Bash configuration files (bash_profile, bash_prompt, bashrc) with useful aliases, prompt customization, and shell settings.
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

## Development

### Pre-commit hooks

Install pre-commit hooks for local development:

```bash
pip install pre-commit
pre-commit install
```

This runs shellcheck, ruff, and other checks before each commit.

## Releases

Each tool is versioned independently using tags in the format `<tool-name>/v<version>`.

To release a new version of a tool:

```bash
git tag git-cleanup/v1.0.0
git push origin git-cleanup/v1.0.0
```

This triggers a GitHub release with the tool files attached.
