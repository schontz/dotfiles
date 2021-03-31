#!/bin/bash
# Custom setup scripts
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

# git
if [ `cat ~/.gitconfig | grep gitconfig_custom | wc -l` -eq 0]
then
  cat "[include]"                    >> ~/.gitconfig
  cat "  path = ~/.gitconfig_custom" >> ~/.gitconfig
fi

