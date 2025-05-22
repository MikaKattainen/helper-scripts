# Helper Scripts

This repository contains a few scripts that I use to help speed things along. Especially when working with a project that constsist of multiple repositories.

NOTE: The scripts are provided as is and they may or may not work. Use at your own discretion.<br/>
NOTE: All the scripts were made for MacOS. They could in theory work on Linux as well but they have not been tested.

## Scripts list
- `docker-volume-containers.sh`: find docker volumes that are no longer in use
- `find-critical-vulnerabilities.sh`: Recursively find vulnerabilities in Node.js projects (yarn or npm supported at the moment), from the folder and subfolders
- `find-repos-with-unstaged-changes.sh`: find repositories where there are unstaged changes
- `git-pull-all.sh`: do a `git pull` for all git projects in the folder and subfolders

## How to use

1. Read the scripts and make sure you understand what they do before running them
2. Save the script on your machine
3. Run the script with `sh path/to/script.sh`
