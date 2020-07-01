#!/usr/bin/env bash

if [ -z "$*" ]

 then
 echo "put branch name ISSUE_NUMBER-BRANCH_NAME"
 exit 0

fi

BRANCH_NAME=$1

echo `git push origin -d ${BRANCH_NAME}`
echo `git branch -d ${BRANCH_NAME}`
