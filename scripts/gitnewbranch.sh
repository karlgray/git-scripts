gitnewbranch() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide the name of the branch - All lowercase words separated by - "
		echo "Prefix should be either feature- or hotfix-"
		return
	fi

	echo "*** Checking out Main ***"
	git checkout main || {
		echo "failed on git checkout of main"
		return
	}

	echo "*** Pull on main to bring it up to date ***"
	git pull || {
		echo "failed on git pull"
		return
	}

	echo "*** Creating branch $1 ***"
	git checkout -b $1 || {
		echo "failed on creation of branch"
		return
	}

	echo "*** Push with --set-upstream origin ***"
	git push --set-upstream origin $1
}