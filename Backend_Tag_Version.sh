#!/bin/bash

# Check if pom.xml exists
if [ ! -f "pom.xml" ]; then
  echo "pom.xml not found! Exiting."
  exit 1
fi

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Get the current version from pom.xml
CURRENT_VERSION=$(/opt/apache-maven-3.8.8/bin/mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# Check if /opt/apache-maven-3.8.8/bin/mvn command was successful
if [ $? -ne 0 ]; then
  echo "Failed to get current version from pom.xml! Exiting."
  exit 1
fi

# Split the version into its components
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"

# Determine whether to increment minor or patch version
if [[ "$BRANCH_NAME" == *"feature"* || "$BRANCH_NAME" == *"bugfix"* ]]; then
  NEW_VERSION="${VERSION_PARTS[0]}.$((VERSION_PARTS[1] + 1)).0"
  COMMIT_MESSAGE="Increment minor version to $NEW_VERSION"
else
  NEW_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.$((VERSION_PARTS[2] + 1))"
  COMMIT_MESSAGE="Increment patch version to $NEW_VERSION"
fi

# Update the version in pom.xml
/opt/apache-maven-3.8.8/bin/mvn versions:set -DnewVersion=$NEW_VERSION-SNAPSHOT -DgenerateBackupPoms=false

# Check if /opt/apache-maven-3.8.8/bin/mvn command was successful
if [ $? -ne 0 ]; then
  echo "Failed to set new version in pom.xml! Exiting."
  exit 1
fi

# Add changes to git
git add pom.xml

# Commit the changes with a message
git commit -m "$COMMIT_MESSAGE"

# Check if git commit was successful
if [ $? -ne 0 ]; then
  echo "Failed to commit changes to git! Exiting."
  exit 1
fi

echo "Version incremented to $NEW_VERSION and changes committed."
