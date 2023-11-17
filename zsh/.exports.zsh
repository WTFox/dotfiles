# == Common Exports ==

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# local bins
export PATH="$HOME/bin:$PATH"

# fzf options
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

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
