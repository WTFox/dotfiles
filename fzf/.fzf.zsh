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
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#000000,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Kanagawa Dragon
# export FZF_DEFAULT_OPTS=" \
#  --color=bg+:#313244,bg:#181616,spinner:#c8c093,hl:#c4746e \
#  --color=fg:#c5c9c5,header:#c4746e,info:#a292a3,pointer:#c8c093\
#  --color=marker:#c8c093,fg+:#c5c9c5,prompt:#a292a3,hl+:#c4746e"

# nordic
# export FZF_DEFAULT_OPTS="\
# --border=none \
# --no-separator \
# --color=fg:#D8DEE9 \
# --color=bg:#1E222A \
# --color=hl:#D8DEE9 \
# --color=fg+:#D8DEE9 \
# --color=bg+:#2E3440 \
# --color=hl+:#D8DEE9 \
# --color=info:#81A1C1 \
# --color=prompt:#81A1C1 \
# --color=pointer:#D8DEE9 \
# --color=marker:#D8DEE9 \
# --color=spinner:#D8DEE9 \
# --color=header:#81A1C1 \
# "

# tokyonight
export FZF_DEFAULT_OPTS="\
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c"
