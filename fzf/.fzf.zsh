# Setup fzf
# ---------
if [[ ! "$PATH" == *"${HOME}/.fzf/bin"* ]]; then
  PATH="${PATH:+${PATH}:}\"${HOME}/.fzf/bin\""
fi

# Auto-completion
# ---------------
source "${HOME}/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "${HOME}/.fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#1c1c1c,bg:#060606,spinner:#a0a8b0,hl:#c2916a \
--color=fg:#dddddd,header:#c2916a,info:#7a8aa6,pointer:#a0a8b0 \
--color=marker:#a08070,fg+:#c7c7c7,prompt:#7a8aa6,hl+:#c2916a \
--color=border:#060606 \
--multi"

# tmux pop up for tab completions in zsh (via fzf-tab plugin)
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
