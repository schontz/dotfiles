#!/bin/bash
# Custom setup scripts

# Install ohmyzsh
if [ ! -d "~/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if test ! "$( command -v brew )"; then
  if [ "$(uname)" == "Darwin" ]; then
    # Unattended install
    # https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
    echo "Installing homebrew"
    echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
  else
    echo "Installing linuxbrew"
    git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
    mkdir ~/.linuxbrew/bin
    ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
    eval "$(~/.linuxbrew/bin/brew shellenv)"
  fi

  echo "Installing brew bundle"
  brew bundle
fi

if [ "$(uname)" == "Darwin" ]; then
  echo -e "\\n\\nRunning on macOS"
  
  # Customize MacOS Defaults
  # https://macos-defaults.com/

  # Sleep shortcut Cmd-Shift-Option-/
  defaults write -g NSUserKeyEquivalents -dict-add Sleep "@^$/"

  # Remove shadow from window screenshots
  defaults write com.apple.screencapture disable-shadow -bool true

  # Show full URL in Safari (not working)
  # defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"

  # Finder path bar
  defaults write com.apple.finder "ShowPathbar" -bool "true"

  # Screenshots to Pictures
  defaults write com.apple.screencapture "location" -string "~/Pictures"

  # Vertical CPU meter icon
  defaults write com.apple.ActivityMonitor "IconType" -int "5"
fi

# git
if [ `cat ~/.gitconfig | grep gitconfig_custom | wc -l` -eq 0]
then
  cat "[include]"                    >> ~/.gitconfig
  cat "  path = ~/.gitconfig_custom" >> ~/.gitconfig
fi

# tmux plugins
# prefix + I to install after updates
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || echo "Already exists"
