#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo -e "\\n\\nRunning on macOS"
  
  # Sleep shortcut Cmd-Shift-Option-/
  defaults write -g NSUserKeyEquivalents -dict-add Sleep "@^$/"

  if test ! "$( command -v brew )"; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
fi

# get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# alias to our dot files
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/alias ~/.alias
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/gvimrc ~/.gvimrc
