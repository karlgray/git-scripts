# Introduction
Here are my .bashrc commands for handling git/github.

I use these in my .bashrc file to quickly run a chain of git commands and to do some basic sanity checks.

My git process is that I have 2 main branches, live and staging.  Live can never be committed to or pushed to locally or on github.
Live can only be merged into via a PR on github.

Staging can be merged locally and pushed to remote where it is automatically deployed using webhooks.  Any developer in the team can merge to staging and test.

To prevent me accidentally pushing from main I ran this command.

 *git config branch.main.pushRemote no_push*

 The gitsave() gitcheckout() and gitcleanup() commands all have checks to prevent them running on main.

 I also configure github not to allow pushes to main.

# What the scripts do.

Each of these should be placed in your .bashrc file then either log out and back in or run this command.

*source ~/.bashrc*

In each command below you will see a brief description of it's intent, the usage, then a list of steps it takes.

## gittest()

This is used to merge active branch into staging branch directly

usage: *gittest*

* Stores name of active branch
* Checks out staging branch
* Merges active branch into staging, 
* Pushes to remote/staging, 
* Checkouts the active branch.


## gitsave()

Used to quickly save your work and push it to remote.

usage: *gitsave "Commit message"*

* Pulls the branch (to bring it up to date with remote)
* Adds all
* Commits with given message
* Pushes to remote/current-branch

## gitcheckout()

This checks out a new branch and brings things up to date.  Prevents checking out main.
if no branch is given it will list available branches.

Once the branch is checked out it will merge from main and push the results to the remote.

This means when you start working on a newly checked branch you are working on the most up to date code.

usage: *gitcheckout branch-name*

* checks out main
* pulls from remote/main
* checks out branch-name
* merges main into branch
* pushes to remote/branch-name.

 ## gitnewbranch()

This creates a new branch.  It first checks out main, does a pull, then creates the branch based on this.

It also pushes and sets the upstream branch.

usage: *gitnewbranch branch-name*

* checks out main
* pulls from remote/main
* creates and checks out new branch-name
* does push and creates upstream remote/branch-name

## gitcleanup()

This does quite a bit and will be added to over time.

It brings main up to date, then brings staging up to date, then brings the current branch up to date.

I am planning to add a loop that goes through each branch (except main) and brings them all up to date.  This may be a separate command or may be in this command in the future.  I need to understand the workflow more before doing this.

usage: *gitcleanup*

* Stores name of active branch
* checks out main
* pulls from remote/main
* checks out staging
* pulls from remote/staging
* merges from main
* pushes back to remote/staging.
* checks out active branch
* merges from main.
* pushes back to remote/active branch
