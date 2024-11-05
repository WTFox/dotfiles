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
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#3a3634,bg:#151515,spinner:#e0d0b0,hl:#ff9f9a \
# --color=fg:#95b9d0,header:#ff9f9a,info:#cba6f7,pointer:#e0d0b0 \
# --color=marker:#e0d0b0,fg+:#95b9d0,prompt:#cba6f7,hl+:#f38ba8"

# Catppuccin-Mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#11111b,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=border:#11111b"

# Kanagawa Dragon
# export FZF_DEFAULT_OPTS=" \
#  --color=bg+:#313244,bg:#181616,spinner:#c8c093,hl:#c4746e \
#  --color=fg:#c5c9c5,header:#c4746e,info:#a292a3,pointer:#c8c093\
#  --color=marker:#c8c093,fg+:#c5c9c5,prompt:#a292a3,hl+:#c4746e"

# tokyonight
# export FZF_DEFAULT_OPTS="\
#   --ansi \
#   --layout=reverse \
#   --border=none \
#   --color=bg+:#283457 \
#   --color=border:#1A1B26 \
#   --color=bg:#1A1B26 \
#   --color=fg:#c0caf5 \
#   --color=gutter:#16161e \
#   --color=header:#ff9e64 \
#   --color=hl+:#2ac3de \
#   --color=hl:#2ac3de \
#   --color=info:#545c7e \
#   --color=marker:#ff007c \
#   --color=pointer:#ff007c \
#   --color=prompt:#2ac3de \
#   --color=query:#c0caf5:regular \
#   --color=scrollbar:#27a1b9 \
#   --color=separator:#ff9e64 \
#   --color=spinner:#ff007c"

# Catppuccin Frappe (Gruvbox Material Dark)
# export FZF_DEFAULT_OPTS="\
# --color=fg:#ebdbb2 \
# --color=fg+:#ebdbb2 \
# --color=bg:#1b1b1b \
# --color=hl:#d3869b \
# --color=bg+:#1d2021 \
# --color=hl+:#d3869b \
# --color=info:#d8a657 \
# --color=prompt:#ea6962 \
# --color=pointer:#ea6962 \
# --color=marker:#a9b665 \
# --color=spinner:#89b482 \
# --color=header:#7daea3 \
# --color=border:#1b1b1b \
# --border=none"
