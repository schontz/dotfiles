export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"

# asdf
# . $(brew --prefix asdf)/asdf.sh

bindkey -v

# jump
[[ -f /usr/local/bin/jump ]] && eval "$(jump shell zsh)"

# added by pdb
bindkey "^P" up-line-or-search

export VISUAL=nvim
export EDITOR=nvim

# From thoughtbot dotfiles
# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# load custom configs
for config in ~/.zsh/configs/*; do
  source $config
done

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

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.alias ]] && source ~/.alias
