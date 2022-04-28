#!/usr/bin/env bash

PROJECT_DIR=$1

echo "Project Directory:"

if [ $# -eq 0 ]; then
	PROJECT_DIR=~/Desktop/Projects
	echo "No directory provided, default directory:"
	echo "$PROJECT_DIR"
else
	echo "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"
pwd

sleep 1

REPOS=0
SUCCESS=0

for d in */ ; do
	FILE="$d/.git"
	if [ -d "$FILE" ]; then
		REPOS="$((REPOS+1))"
		echo ""
		echo "$d"
		cd $d
		if [[ `git status --porcelain` ]]; then
			echo "$d has untracked/unsaved changes. Did not pull"
		else
			git pull
			SUCCESS="$((SUCCESS+1))"
		fi
		cd ..
	fi
done

echo ""

if [ REPOS == 0 ]; then
	echo "No git repository exists in the directory"
else
	echo "Total Repositories: $REPOS"
	echo "Possible pulls: $SUCCESS"
	echo "Unsaved changes in $((REPOS-SUCCESS)) repositories"
fi
