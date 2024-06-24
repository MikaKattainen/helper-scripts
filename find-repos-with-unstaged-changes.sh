#!/bin/bash

dir=${1:-.}

rootDir=$(pwd)
gitDirectories=$(find "$dir" -name 'node_modules' -prune -o -name '.git' -print)

# Function to find git repositories with unstaged changes
find_git_repos_with_unstaged_changes() {
    for gitDir in $gitDirectories; do
       dir=$(dirname "$gitDir" | sed "s|^\./|$rootDir/|")
       cd "$dir" || exit
        if ! git diff --exit-code > /dev/null; then
            echo "Unstaged changes in $dir"
        fi
        if ! git diff --cached --exit-code > /dev/null; then
            echo "Uncommitted changes in $dir"
        fi
    done
}

# Call the function with the provided path
find_git_repos_with_unstaged_changes
