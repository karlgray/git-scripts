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

	echo "*** Pull from branch $branch_name to bring it up to date ***"
	git pull || {
		echo "failed on git pull"
		return
	}

	echo "*** add all ***"
	git add .

	echo "*** Commit ***"
	git commit -m "$1"
	
	echo "*** Push to branch $branch_name to bring it up to date ***"
	git push || {
		echo "failed on git push to origin for branch $branch_name"
		return
	}
	
}