
export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
source /Users/davidschontzler/.asdf/asdf.sh
source ~/.alias
bindkey -v

# added by pdb
bindkey "^P" up-line-or-search

export VISUAL=vim
export EDITOR=vim

# From thoughtbot dotfiles
# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# load custom configs
source ~/.zsh/configs/color.zsh
source ~/.zsh/configs/keybindings.zsh
source ~/.zsh/configs/options.zsh

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git branch --show-current 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}

setopt promptsubst

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='
${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
\$ '
fi


# Deno
export DENO_INSTALL="/Users/davidschontzler/.local"
export PATH="$DENO_INSTALL/bin:$PATH"


