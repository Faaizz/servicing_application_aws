#!/bin/bash

# Clone specified git repository to specified directory
# Usage: clone_git_repository.sh <git_repository> <directory>
# Example: clone_git_repository.sh https://ghp_AAAAAAAAAA@github.com/example/repo.git .

# Cleanup existing directory
rm -rf $2 || true

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git could not be found"
    exit
fi

# Check if git repository is specified
if [ -z "$1" ]
then
    echo "Git repository is not specified"
    exit
fi

# Check if directory is specified
if [ -z "$2" ]
then
    echo "Directory is not specified"
    exit
fi

# Clone git repository to specified directory
git clone $1 $2
exit $?
