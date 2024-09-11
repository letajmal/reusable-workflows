#!/bin/bash

function gh_api_call () {

# ref: https://docs.github.com/en/rest/commits/commits?apiVersion=2022-11-28#get-a-commit
API_ENDPOINT="https://api.github.com/repos/$1/$2/commits/$3"

# api call to retrieve info about the latest commit
COMMIT=$(curl -L -H 'Accept: application/vnd.github+json' \
-H "Authorization: Bearer $TOKEN" \
-H 'X-GitHub-Api-Version: 2022-11-28' "$API_ENDPOINT")

# taking commit sha, message and author from api call output
SHA=$(echo "$COMMIT" | jq -r '.sha')
MESSAGE=$(echo "$COMMIT" | jq -r '.commit.message')
AUTHOR=$(echo "$COMMIT" | jq -r '.commit.author.name')

# creating the changelog file
echo -e "\n## $2/$3" >> "$LOG_FILE"
echo -e "\n- *SHA* :hash:\n\`\`\`\n$SHA\n\`\`\`" >> "$LOG_FILE"
echo -e "\n- *Message* :memo:\n\`\`\`\n$MESSAGE\n\`\`\`" >> "$LOG_FILE"
echo -e "\n- *Author* :technologist:\n\`\`\`\n$AUTHOR\n\`\`\`" >> "$LOG_FILE"

}

# $1 - environment
ENV=$1
# $2 - git token
TOKEN=$2

# Check if an env was provided
if [ -z "$ENV" ]; then
  echo "Usage: $0 $environment"
  exit 1
fi

# Path to the apps.json file and the log file
APPS_JSON="$ENV/apps.json"
LOG_FILE="$ENV/COMMIT.md"

# timestamp
echo "*`date`*" > "$LOG_FILE"

# Iterate over each element in the JSON array
jq -c '.[]' "$APPS_JSON" | while read -r APP; do
    # Extract the URL and branch from each JSON object
    URL=$(echo "$APP" | jq -r '.url')
    BRANCH=$(echo "$APP" | jq -r '.branch')

    # Extracting OWNER and REPO name from URL
    OWNER=$(echo "$URL" | awk -F'/' '{print $4}')
    REPO=$(echo "$URL" | awk -F'/' '{print $5}')

    gh_api_call $OWNER $REPO $BRANCH
done