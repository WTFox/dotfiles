# == Common Exports ==

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

export VISUAL='nvim'

# local bins
export PATH="$HOME/bin:$PATH"

# fzf options (catppuccin theme)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# golang
export GOPATH="$HOME/dev/go"
export PATH="$PATH:$GOPATH/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# ruby
export PATH="$PATH:$HOME/.rvm/bin" 

# rust
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.cargo/env"

# pipx and more
export PATH="$HOME/.local/bin:$PATH"

# virtualenvs
export WORKON_HOME="$HOME/.envs"
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"

# yarn
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
