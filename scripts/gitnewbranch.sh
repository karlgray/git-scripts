gitnewbranch() {
	if [ "$#" -ne 1 ]; then
		echo -e "${RED}You need to provide the name of the branch - All lowercase words separated by - ${NC}"
		echo -e "${RED}Prefix should be either feature- or hotfix-${NC}"
		return
	fi

	echo -e "${GREEN}*** Checking out Main ***${NC}"
	git checkout main || {
		echo -e "${RED}failed on git checkout of main${NC}"
		return
	}

	echo -e "${GREEN}*** Pull on main to bring it up to date ***${NC}"
	git pull || {
		echo -e "${RED}failed on git pull${NC}"
		return
	}

	echo -e "${GREEN}*** Creating branch $1 ***${NC}"
	git checkout -b $1 || {
		echo -e "${RED}failed on creation of branch${NC}"
		return
	}

	echo -e "${GREEN}*** Push with --set-upstream origin ***${NC}"
	git push --set-upstream origin $1
}