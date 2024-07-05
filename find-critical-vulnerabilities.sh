#!/bin/bash

dir=${1:-.} # Start directory, default to current if not provided
tmp_file=$(mktemp) # Create a temporary file

# Function to check for vulnerabilities
check_vulnerabilities() {
    package_dir=$(realpath "$1")
    critical_count=0
    cd "$package_dir" || return # Change to the directory, skip if it fails
    if [[ -f "package-lock.json" ]]; then
        critical_count=$(npm audit --json | jq '.metadata.vulnerabilities.critical' | jq 'select(. != null)')
    elif [[ -f "yarn.lock" ]]; then
        critical_count=$(yarn audit --json | jq '.data.vulnerabilities.critical' | jq 'select(. != null)')
    fi

    if [[ $critical_count -gt 0 ]]; then
        echo "$package_dir: $critical_count critical vulnerabilities" >> "$tmp_file"
    fi
}

export -f check_vulnerabilities # Export the function for use with find -exec
export tmp_file # Make sure the temporary file is accessible in the subshell

# Find package.json files, ignoring node_modules, and check each for vulnerabilities
find "$dir" -name 'node_modules' -prune -o -name 'package.json' -exec bash -c 'check_vulnerabilities "$(dirname "{}")"' \;

# Output results
if [[ ! -s $tmp_file ]]; then
    echo "No directories with critical vulnerabilities found."
else
    echo "Directories with critical vulnerabilities:"
    cat "$tmp_file"
fi

rm "$tmp_file" # Clean up the temporary file
