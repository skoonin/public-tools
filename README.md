# public-tools

A collection of some tools I've written for myself that have been useful.

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
