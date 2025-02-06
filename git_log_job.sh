#!/bin/bash

# Set variables
REPO_URL="https://github.com/nikhilnsalgaonkar/todo-list-app.git"
WORK_DIR="/tmp/todo-list-app"
LOG_FILE="/tmp/gitlog_$(date +%d%m%Y).txt"

# Clone the repository
git clone $REPO_URL $WORK_DIR

# Navigate to the repository folder
cd $WORK_DIR

# Get the last 5 commits and write author and modified files to the log file
git log -n 5 --pretty=format:"%nAuthor: %an%nFiles Changed:%n" --name-only | grep -v "^$" >> $LOG_FILE

# Clean up by deleting the repository folder
rm -rf $WORK_DIR