gitcleanup() {
	branch_name="$(git symbolic-ref --short -q HEAD)"
	if [ $branch_name = "main" ]
	then
		echo "Do not run this on main.${NC}"
		return
	fi

	echo "${GREEN}*** Checking out Main ***${NC}"
	git checkout main || {
		echo "Failed to checkout main${NC}"
		return
	}

	echo "${GREEN}*** Pull on Main to bring it up to date ***${NC}"
	git pull || {
		echo "failed on git pull${NC}"
		return
	}

	echo "${GREEN}*** Checking out Staging ***${NC}"
	git checkout staging || {
		echo "failed on git checkout of staging${NC}"
		return
	}

	echo "${GREEN}*** Pull on Staging to bring it up to date ***${NC}"
	git pull || {
		echo "failed on git pull of staging${NC}"
		return
	}

	echo "${GREEN}*** Merge from Main into Staging to bring it up to date ***${NC}"
	git merge main || {
		echo "Couldn't merge main into staging${NC}"
		return
	}

	echo "${GREEN}*** Push to staging - will also run deploy script ***${NC}"
	git push || {
		echo "failed on git push to cpstaging${NC}"
		return
	}

	echo "${GREEN}*** Checking out original branch $branch_name ***${NC}"
	git checkout $branch_name || {
		echo "failed on git checkout of $branch_name ${NC}"
		return
	}

	echo "${GREEN}*** Merge Main again to bring current branch up to date ***${NC}"
	git merge main || {
		echo "failed on merging main into $branch_name ${NC}"
		return
	}

	echo "${GREEN}*** Push branch $branch_name to origin ***${NC}"
	git push || {
		echo "failed on git push to $branch_name ${NC}"
		return
	}
}