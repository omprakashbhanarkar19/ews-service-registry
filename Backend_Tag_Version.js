const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

try {
  // Check if pom.xml exists
  if (!fs.existsSync('pom.xml')) {
    console.error('pom.xml not found! Exiting.');
    process.exit(1);
  }

  // Print current directory
  console.log('Current directory:', process.cwd());

  // Get the current branch name
  const BRANCH_NAME = execSync('git rev-parse --abbrev-ref HEAD').toString().trim();
  console.log('Current branch name:', BRANCH_NAME);

  // Get the current version from pom.xml
  let CURRENT_VERSION;
  try {
    CURRENT_VERSION = execSync('mvn help:evaluate -Dexpression=project.version -q -DforceStdout').toString().trim();
    console.log('Current version:', CURRENT_VERSION);
  } catch (err) {
    console.error('Failed to get current version from pom.xml! Exiting.');
    process.exit(1);
  }

  // Split the version into its components
  const VERSION_PARTS = CURRENT_VERSION.split('.').map(part => parseInt(part, 10));

  // Determine whether to increment minor or patch version
  let NEW_VERSION, COMMIT_MESSAGE;
  if (BRANCH_NAME.includes('feature') || BRANCH_NAME.includes('bugfix')) {
    NEW_VERSION = `${VERSION_PARTS[0]}.${VERSION_PARTS[1] + 1}.0`;
    COMMIT_MESSAGE = `Increment minor version to ${NEW_VERSION}`;
  } else {
    NEW_VERSION = `${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2] + 1}`;
    COMMIT_MESSAGE = `Increment patch version to ${NEW_VERSION}`;
  }

  // Update the version in pom.xml
  let pomXml = fs.readFileSync('pom.xml', 'utf8');
  pomXml = pomXml.replace(/<version>[0-10]+\.[0-10]+\.[0-10]+<\/version>/, `<version>${NEW_VERSION}</version>`);
  fs.writeFileSync('pom.xml', pomXml, 'utf8');

  console.log(`Version updated to ${NEW_VERSION}`);

  // Commit the changes without triggering a build
  execSync('git add pom.xml');
  execSync(`git commit -m "${COMMIT_MESSAGE}"`);

  console.log('Changes committed successfully.');
} catch (err) {
  console.error('An error occurred:', err.message);
  process.exit(1);
}
