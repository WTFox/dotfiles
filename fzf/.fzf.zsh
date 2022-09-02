# Setup fzf
# ---------
if [[ ! "$PATH" == */home/wtfox/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/wtfox/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/wtfox/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/wtfox/.fzf/shell/key-bindings.zsh"
