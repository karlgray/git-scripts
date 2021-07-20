gitcleanup() {
	branch_name="$(git symbolic-ref --short -q HEAD)"
	if [ $branch_name = "main" ]
	then
		"Do not run this on main."
		return
	fi

	echo "*** Checking out Main ***"
	git checkout main || {
		echo "Failed to checkout main"
		return
	}

	echo "*** Pull on Main to bring it up to date ***"
	git pull || {
		echo "failed on git pull"
		return
	}

	echo "*** Checking out Staging ***"
	git checkout staging || {
		echo "failed on git checkout of staging"
		return
	}

	echo "*** Pull on Staging to bring it up to date ***"
	git pull || {
		echo "failed on git pull of staging"
		return
	}

	echo "*** Merge from Main into Staging to bring it up to date ***"
	git merge main || {
		echo "Couldn't merge main into staging"
		return
	}

	echo "*** Push to staging - will also run deploy script ***"
	git push || {
		echo "failed on git push to cpstaging"
		return
	}

	echo "*** Checking out original branch $branch_name ***"
	git checkout $branch_name || {
		echo "failed on git checkout of $branch_name "
		return
	}

	echo "*** Merge Main again to bring current branch up to date ***"
	git merge main || {
		echo "failed on merging main into $branch_name "
		return
	}

	echo "*** Push branch $branch_name to origin ***"
	git push || {
		echo "failed on git push to $branch_name "
		return
	}
}