# checks out staging branch, merges active branch, pushes, then checkouts the active branch.
gittest() {
	branch_name="$(git symbolic-ref --short -q HEAD)"

	echo -e "${GREEN}*** Checkout Staging ***${NC}"
	git checkout staging || {
		echo -e "${RED}failed on git checkout of staging${NC}"
		return
	}

	echo -e "${GREEN}*** Pull to bring staging up to date ***${NC}"
	git pull || {
		echo -e "${RED}failed on git pull of Staging${NC}"
		return
	}
	
	echo -e "${GREEN}*** Merge branch $branch_name into staging ***${NC}"
	git merge $branch_name || {
		echo -e "${RED}Couldn't merge branch $branch_name into staging${NC}"
		return
	}

	echo -e "${GREEN}*** Push to staging - will also run deploy script ***${NC}"
	git push || {
		echo -e "${RED}failed on git push to cpstaging${NC}"
		return
	}
	
	echo -e "${GREEN}*** Checking out original branch $branch_name ***${NC}"
	git checkout $branch_name
}
