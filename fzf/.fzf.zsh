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

# Jellybeans Muted colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#3c3b38,bg:#101010,spinner:#7db7cc,hl:#d9a45a \
--color=fg:#dad6c8,header:#d9a45a,info:#7a8aa6,pointer:#d8a16c \
--color=marker:#98b67c,fg+:#f9f5ec,prompt:#83adc3,hl+:#7a8aa6 \
--color=border:#3c3936 \
--multi"
