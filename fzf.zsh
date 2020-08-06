# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# Use ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

export FZF_DEFAULT_OPTS="--reverse --border=horizontal"
