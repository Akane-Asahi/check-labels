#!/bin/bash

# Check if the "index.html" file exists
if [ ! -f index.html ]; then
  echo "index.html not found. Test failed."
else
  # Check if the first line of "index.html" contains "<!DOCTYPE html>"
  if head -n 1 index.html | grep -q "<!DOCTYPE html>"; then
    echo "Test passed. Adding 'pass' label to the commit."
    # Replace 'MY_TOKEN' with your actual GitHub token
    # Replace 'my-username' with your GitHub username
    # Replace 'my-repository' with your GitHub repository name
    curl -X POST -H "Authorization: token MY_TOKEN" -d '{"labels":["pass"]}' "https://api.github.com/repos/Akane-Asahi/check-labels/issues/$(git rev-parse --abbrev-ref HEAD)/labels"
  else
    echo "Test failed. Adding 'flaky' label to the commit."
    # Replace 'MY_TOKEN' with your actual GitHub token
    # Replace 'my-username' with your GitHub username
    # Replace 'my-repository' with your GitHub repository name
    curl -X POST -H "Authorization: token MY_TOKEN" -d '{"labels":["flaky"]}' "https://api.github.com/repos/Akane-Asahi/check-labels/issues/$(git rev-parse --abbrev-ref HEAD)/labels"
  fi
fi
