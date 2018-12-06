#!/bin/bash

REQUEST_INTERVAL="3" # Was set to 3 seconds
MAX_DOWNLOAD_SPEED="250k" # Was set to 50k
USER_AGENT='Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:61.0)' # Windows 10 using Firefox 61

if [ "$#" -eq 1 ]; then
  DOMAIN=$(echo $1 | sed -e "s/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/" | awk -F '.' '{print $(NF-1)"."$(NF)}')
  echo "==> Downloading website from $1 restricted to domain $DOMAIN"
  wget \
    --recursive \
    --page-requisites \
    --convert-links \
    --restrict-file-names=windows \
    --domains "$DOMAIN" \
    --no-parent \
    --mirror \
    --verbose \
    --wait="$REQUEST_INTERVAL" \
    --limit-rate="$MAX_DOWNLOAD_SPEED" \
    --user-agent="$USER_AGENT" \
    "$1"
else
  echo "usage: $(basename $0) <url>"
fi
