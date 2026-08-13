#!/bin/bash
# Custom setup scripts

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# zsh: source dotfiles zshrc if not already present
# Must run before the oh-my-zsh install: --keep-zshrc only protects an *existing*
# ~/.zshrc, so with no file there the installer drops in its own template.
if [ ! -f ~/.zshrc ] || [ "$(grep -c "$DOTFILES_DIR/zshrc" ~/.zshrc)" -eq 0 ]; then
  printf "\nsource %s/zshrc\n" "$DOTFILES_DIR" >>~/.zshrc
fi

# Install ohmyzsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc --unattended
fi

# Install p10k
if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  echo "Installing powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install homebrew
if test ! "$(command -v brew)"; then
  if [ "$(uname)" == "Darwin" ]; then
    # Unattended install
    # https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
    echo "Installing homebrew"
    echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installing brew bundle"
    brew bundle
  # else
  #   echo "Installing linuxbrew"
  #   git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
  #   mkdir ~/.linuxbrew/bin
  #   ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
  #   eval "$(~/.linuxbrew/bin/brew shellenv)"
  #   echo "Installing brew bundle"
  #   brew bundle
  fi
fi

# Install fasd
FASD_TMP=$(mktemp -d)
git clone https://github.com/clvv/fasd "$FASD_TMP"
PREFIX=$HOME make -C "$FASD_TMP" install
rm -rf "$FASD_TMP"

# Customize macOS
if [ "$(uname)" == "Darwin" ]; then
  echo -e "\\n\\nCustomizing macOS"

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

# git: add include for gitconfig.conf
if [ ! -f ~/.gitconfig ] || [ "$(grep -c "$DOTFILES_DIR/gitconfig.conf" ~/.gitconfig)" -eq 0 ]; then
  printf "\n[include]\n  path = %s/gitconfig.conf\n" "$DOTFILES_DIR" >>~/.gitconfig
fi

# tmux plugins
# prefix + I to install after updates
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || echo "Already exists"
