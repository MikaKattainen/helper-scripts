#!/bin/bash

# Check if a directory was provided as an argument, if not default to the current directory
dir=${1:-.}

rootDir=$(pwd)
gitDirectories=$(find "$dir" -name 'node_modules' -prune -o -name '.git' -print)

# Function to update git repositories
update_git_repos() {
    for gitDir in $gitDirectories; do
        echo "------------------------------------------------------------"
        echo "------------------------------------------------------------"
        echo "\n \n"
        # Convert the path to an absolute path before using it with the cd command
        dir=$(dirname "$gitDir" | sed "s|^\./|$rootDir/|")
        cd "$dir" || exit
        echo "Updating $dir"

        echo "git stash"
        git stash
        echo "git pull"
        git pull
        echo "done"
        echo "\n \n"
    done
}

# Call the function with the provided path
update_git_repos
