# public-tools

A collection of some tools I've written for myself that have been useful.

- ec2-search
  - Helpful to audit EC2 instances. Finds all EC2 instances and prints out their state, location, ID and any or all tags.
- gh-search
  -  Searches GitHub for a given string and prints out the repos that contain it. Also gives you links and can clone the code and open a VS code session with all repos.
- git-update-branches
  - Iterates through a directory of git repos and pulls and prunes the default branch. It saves your repo state (stash, branch) and resets it back to where you left it once its done.