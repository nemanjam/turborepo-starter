#!/bin/bash

# Reusable function to either print or remove files/directories based on the dry-run flag
clean() {
  if [ "$DRY_RUN" = true ]; then
    find . -name "$1" -type "$2" -prune -print
  else
    find . -name "$1" -type "$2" -prune -exec rm -rf '{}' +
  fi
}

# Check for dry-run flag
DRY_RUN=false
if [ "$2" = "--dry-run" ]; then
  DRY_RUN=true
fi

# Check the first argument and call the clean function accordingly
case $1 in
  node_modules)
    clean "node_modules" d
    ;;
  turbo)
    clean ".turbo" d
    ;;
  lock)
    clean "yarn.lock" f
    ;;
  all)
    clean "node_modules" d
    clean ".turbo" d
    clean "yarn.lock" f
    ;;
  *)
    echo "Usage: $0 {node_modules|turbo|lock} [--dry-run]"
    exit 1
    ;;
esac
