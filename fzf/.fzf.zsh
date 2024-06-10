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

# Colors
# Catppuccin
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#0e0e13,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Kanagawa Dragon
export FZF_DEFAULT_OPTS=" \
 --color=bg+:#313244,bg:#181616,spinner:#c8c093,hl:#c4746e \
 --color=fg:#cdd6f4,header:#c4746e,info:#938aa9,pointer:#c8c093\
 --color=marker:#c8c093,fg+:#cdd6f4,prompt:#938aa9,hl+:#c4746e"
