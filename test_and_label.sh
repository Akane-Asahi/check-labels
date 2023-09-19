#!/bin/bash

# Check if the "index.html" file exists
if [ ! -f index.html ]; then
  echo "index.html not found. Test failed."
  exit 1
fi

# Check if the first line of "index.html" contains "<!DOCTYPE html>"
if head -n 1 index.html | grep -q "<!DOCTYPE html>"; then
  echo "Test passed. Adding 'pass' label to the commit."
  # Replace 'your_github_token' with your actual GitHub token
  curl -X POST -H "Authorization: token MY_TOKEN" -d '{"labels":["pass"]}' https://api.github.com/repos/Akane-Asahi/check-labels/issues/$(git rev-parse --abbrev-ref HEAD | sed 's/[^0-9]*//g')/labels
else
  echo "Test failed. Adding 'flaky' label to the commit."
  # Replace 'your_github_token' with your actual GitHub token
  curl -X POST -H "Authorization: token MY_TOKEN" -d '{"labels":["flaky"]}' https://api.github.com/repos/Akane-Asahi/check-labels/issues/$(git rev-parse --abbrev-ref HEAD | sed 's/[^0-9]*//g')/labels
  exit 1
fi
