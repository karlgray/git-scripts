# Checksout a branch and merges from main to bring it up to date and then pushes.
gitcheckout() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide branch to checkout"
		git branch
		return
	fi

	if [ $1 = "main" ]
	then
		echo "Cannot checkout main,  use native git commands."
		return
	fi

	echo "*** Checkout Main ***"
	git checkout main || {
		echo "failed on git checkout of main"
		return
	}

	echo "*** Pull to bring Main up to date ***"
	git pull || {
		echo "failed on git pull"
		return
	}

	echo "*** Checking out branch $1 ***"
	git checkout $1 || {
		echo "failed on branch checkout"
		return
	}

	echo "*** Merge Main into branch $1 ***"
	git merge main || {
		echo "Couldn't merge main into $1"
		return
	}

	echo "*** Push branch $1 up to origin ***"
	git push

}