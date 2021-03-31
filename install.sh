#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo -e "\\n\\nRunning on macOS"
  
  # Customize MacOS Defaults
  # https://macos-defaults.com/

  # Sleep shortcut Cmd-Shift-Option-/
  # defaults write -g NSUserKeyEquivalents -dict-add Sleep "@^$/"

  # Remove shadow from window screenshots
  defaults write com.apple.screencapture disable-shadow -bool true

  if test ! "$( command -v brew )"; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  
    echo "Installing brew bundle"
    brew bundle
  fi
else
  echo "Cloning asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
fi

# get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# zsh
echo "Setting up zsh..."
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/alias ~/.alias
mkdir -p ~/.zsh/configs
cp $DIR/zsh/configs/* ~/.zsh/configs/
mkdir -p ~/.zsh/functions
cp $DIR/zsh/functions/* ~/.zsh/functions/

# nvim
echo "Setting up nvim..."
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/gvimrc ~/.gvimrc
mkdir -p ~/.config/nvim
ln -s $DIR/config/nvim/coc-settings.json ~/.config/nvim/
ln -s $DIR/config/nvim/cocrc.vim ~/.config/nvim/
ln -s $DIR/config/nvim/plugin ~/.config/nvim/

# fzf
echo "Setting up fzf..."
ln -s $DIR/fzf.zsh ~/.fzf.zsh

# git
if [ `cat ~/.gitconfig | grep START_DOTFILES | wc -l` -gt 0]
then
  cat gitconfig >> ~/.gitconfig
fi
