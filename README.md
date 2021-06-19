# Introduction
Bashrc commands for handling git/github.

I use these in my .bashrc file to quickly run a chain of git commands and to do some basic sanity checks.

My git process is that I have 2 main branches, live and staging.  Live can never be committed to or pushed to on github.
Live can only be merged into via a PR on github.

Staging can be merged locally and pushed to remote where it is automatically deployed using webhooks.  Any developer in the team can merge to staging and test.

To prevent me accidentally pushing from main I ran this command.

 *git config branch.main.pushRemote no_push*

 The gitsave() gitcheckout() and gitcleanup() commands all have checks to prevent them running on main.

 I also configure github not to allow pushes to main.

# What the scripts do.

Each of these should be placed in your .bashrc file then either log out and back in or run this command.  
*source ~/.bashrc*

## gittest()

This is used to merge active branch into staging branch directly

usage: *gittest*

* Checks out staging branch
* Merges active branch, 
* Pushes, 
* Checkouts the active branch.


## gitsave()

Used to quickly save your work and push it to remote.

usage: *gitsave "Commit message"*

* Pulls the branch (to bring it up to date with remote)
* Adds all
* Commits with given message
* Pushes to remote

