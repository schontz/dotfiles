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

# zsh
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/alias ~/.alias
mkdir -p ~/.zsh/
ln -s $DIR/zsh/configs ~/.zsh/
ln -s $DIR/zsh/functions ~/.zsh/

# nvim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/gvimrc ~/.gvimrc
mkdir -p ~/.config/nvim
ln -s $DIR/config/nvim/coc-settings.json ~/.config/nvim/
ln -s $DIR/config/nvim/cocrc.vim ~/.config/nvim/

# fzf
ln -s $DIR/fzf.zsh ~/.fzf.zsh
