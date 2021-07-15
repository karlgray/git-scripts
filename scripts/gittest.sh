# checks out staging branch, merges active branch, pushes, then checkouts the active branch.
gittest() {
	branch_name="$(git symbolic-ref --short -q HEAD)"

	echo "*** Checkout Staging ***"
	git checkout staging || {
		echo "failed on git checkout of staging"
		return
	}

	echo "*** Pull to bring staging up to date ***"
	git pull || {
		echo "failed on git pull of Staging"
		return
	}
	
	echo "*** Merge branch $branch_name into staging ***"
	git merge $branch_name || {
		echo "Couldn't merge branch $branch_name into staging"
		return
	}

	echo "*** Push to staging - will also run deploy script ***"
	git push || {
		echo "failed on git push to cpstaging"
		return
	}
	
	echo "*** Checking out original branch $branch_name ***"
	git checkout $branch_name
}
