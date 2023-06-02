# User configuration
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# personal bins
export PATH=$HOME/bin:$PATH
export PATH=$HOME/bin/nvim-macos/bin/:$PATH

# fzf
# set catppuccin theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

# golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# postgres
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

# pipx
export PATH=$HOME/.local/bin/:$PATH

# python
export PATH="/usr/local/opt/python/libexec/bin:~/Library/Python/3.11/bin/:$PATH"

# ruby
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# rust
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.cargo/env" 

# virtualenvs
export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# yarn
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
