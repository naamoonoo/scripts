#!/usr/bin/env bash

if [ -z "$*" ]

 then
 echo "put branch name ISSUE_NUMBER-BRANCH_NAME"
 exit 0

fi

BRANCH_NAME=$1

echo `git checkout -b ${BRANCH_NAME}`
echo `git push --set-upstream origin ${BRANCH_NAME}`
