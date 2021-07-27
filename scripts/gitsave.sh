#  pulls the branch to bring it up to date with remote,  adds all, commits with given message the pushes to remote
gitsave() {
	if [ "$#" -ne 1 ]; then
		echo -e "${RED}You need to provide commit message/comment${NC}"
		return
	fi

	branch_name="$(git symbolic-ref --short -q HEAD)"
	if [ $branch_name = "main" ]
	then
		echo -e "${RED}Cannot add, or commit to main, use branch.${NC}"
		return
	fi

	echo -e "${GREEN}*** Pull from branch $branch_name to bring it up to date ***${NC}"
	git pull || {
		echo -e "${RED}failed on git pull${NC}"
		return
	}

	echo -e "${GREEN}*** add all ***${NC}"
	git add .

	echo -e "${GREEN}*** Commit ***${NC}"
	git commit -m "$1"
	
	echo -e "${GREEN}*** Push to branch $branch_name to bring it up to date ***${NC}"
	git push || {
		echo -e "${RED}failed on git push to origin for branch $branch_name${NC}"
		return
	}
	
}