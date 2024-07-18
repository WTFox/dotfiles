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
# Catppuccin-Macchiato
export FZF_DEFAULT_OPTS=" \
--color=bg+:#3a3634,bg:#151515,spinner:#e0d0b0,hl:#ff9f9a \
--color=fg:#95b9d0,header:#ff9f9a,info:#cba6f7,pointer:#e0d0b0 \
--color=marker:#e0d0b0,fg+:#95b9d0,prompt:#cba6f7,hl+:#f38ba8"

# Catppuccin-Mocha
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#11111b,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Kanagawa Dragon
# export FZF_DEFAULT_OPTS=" \
#  --color=bg+:#313244,bg:#181616,spinner:#c8c093,hl:#c4746e \
#  --color=fg:#c5c9c5,header:#c4746e,info:#a292a3,pointer:#c8c093\
#  --color=marker:#c8c093,fg+:#c5c9c5,prompt:#a292a3,hl+:#c4746e"
