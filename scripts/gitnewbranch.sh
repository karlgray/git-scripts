gitnewbranch() {
	if [ "$#" -ne 1 ]; then
		echo "You need to provide the name of the branch - All lowercase words separated by - "
		echo "Prefix should be either feature- or hotfix-"
		return
	fi

	echo "${GREEN}*** Checking out Main ***${NC}"
	git checkout main || {
		echo "failed on git checkout of main"
		return
	}

	echo "${GREEN}*** Pull on main to bring it up to date ***${NC}"
	git pull || {
		echo "failed on git pull"
		return
	}

	echo "${GREEN}*** Creating branch $1 ***${NC}"
	git checkout -b $1 || {
		echo "failed on creation of branch"
		return
	}

	echo "${GREEN}*** Push with --set-upstream origin ***${NC}"
	git push --set-upstream origin $1
}