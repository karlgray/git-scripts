# checks out staging branch, merges active branch, pushes, then checkouts the active branch.
gittest() {
	branch_name="$(git symbolic-ref --short -q HEAD)"
	git checkout staging
	git pull
	git merge $branch_name
	git push
	git checkout $branch_name
}

#  pulls the branch to bring it up to date with remote,  adds all, commits with given message the pushes to remote
gitsave() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide commit message/comment"
		return
	fi

	branch_name="$(git symbolic-ref --short -q HEAD)"
	if [ $branch_name = "main" ]
	then
		echo "Cannot add, or commit to main, use branch."
		return
	fi

	git pull
	git add .
	git commit -m "$1"
	git push
}

# Checksout a branch and merges from main to bring it up to date and then pushes.
gitcheckout() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide branch to checkout"
		return
	fi

	if [ $1 = "main" ]
	then
		echo "Cannot checkout main,  use native git commands."
		return
	fi

# Checkout branch
git checkout $1
# Catch us up to main
git merge main
# push to branch origin.
git push
# All up to date now
}

gitnewbranch() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide the name of the branch - All lowercase words separated by - "
		echo "Prefix should be either feature- or hotfix-"
		return
	fi

	git checkout main || {
		echo "failed on git checkout of main"
		return
	}

	git pull || {
		echo "failed on git pull"
		return
	}

	git checkout -b $1 || {
		echo "failed on creation of branch"
		return
	}

	git push --set-upstream origin $1
}

gitcleanup() {
	branch_name="$(git symbolic-ref --short -q HEAD)"
	if [ $branch_name = "main" ]
	then
		echo "Do not run this on main."
		return
	fi

	git checkout main || {
		echo "Failed to checkout main"
		return
	}

	git pull || {
		echo "failed on git pull"
		return
	}

	git checkout staging || {
		echo "failed on git checkout of staging"
		return
	}

	git pull || {
		echo "failed on git pull"
		return
	}

	git merge main || {
		echo "Couldn't merge main into staging"
		return
	}

	git push || {
		echo "failed on git push to cpstaging"
		return
	}

	git checkout $branch_name || {
		echo "failed on git checkout of $branch_name"
		return
	}

	git merge main || {
		echo "failed on git push to $branch_name"
		return
	}
}



