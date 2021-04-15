#!/bin/bash

# default git master branch name
MASTER=master

# Store our master branch names
CACHE="$HOME/.master_git_names"

if [[ ! -f "${CACHE}" ]]; then
  touch ${CACHE}
fi

REMOTE_URL="$(git config --get remote.origin.url)"

if [[ "$REMOTE_URL" ]]; then
  MATCH=`awk -v pat="$REMOTE_URL" '$1 == pat' $CACHE | awk '{ print $2 }'`
  if [[ $MATCH ]]; then
    MASTER=$MATCH
  else
    MASTER="$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)"
    echo "${REMOTE_URL} ${MASTER}" >> "${CACHE}"
  fi
fi

echo $MASTER
