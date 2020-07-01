
#!/usr/bin/env bash

COMMIT_MSG_FILE=$1

branch_name=`git rev-parse --abbrev-ref HEAD`
issue_number=`echo ${branch_name} | cut -d '-' -f1`
first_line=`head -n1 ${COMMIT_MSG_FILE}`

if [ -z "$first_line" ]; then
   sed -i ".bak" "1s/^/[#$issue_number] /" ${COMMIT_MSG_FILE}
 fi

# npm install husky@next --save-dev

# "husky" : {
#   "hooks": {
#     "prepare-commit-msg": ".${folder}/add_issue_number_into_commit.sh $HUSKY_GIT_PARAMS"
#   }
# }