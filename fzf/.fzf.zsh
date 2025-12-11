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
--color=bg+:#1f1f1f,bg:#101010,spinner:#7db7cc,hl:#d9a45a \
--color=fg:#e8e8d3,header:#cc88a3,info:#b0d0f0,pointer:#d8a16c \
--color=marker:#99b67c,fg+:#e8e8d3,prompt:#83adc3,hl+:#e6a75a \
--color=border:#101010 \
--multi"
