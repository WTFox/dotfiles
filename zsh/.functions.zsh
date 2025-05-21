function load_pyenv() {
  if type pyenv > /dev/null 2>&1; then
      return
  fi
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

function load_nvm() {
  if type nvm > /dev/null 2>&1; then
      return
  fi
  export NVM_DIR="$HOME/.nvm"

  [ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

function ubuntu(){
  docker run -it -w '/entrypoint/' -v "$(pwd)":/entrypoint ubuntu:latest
}

function profile_zsh() {
  for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done;
}

function gi() {
  # echos a gitignore template to stdout
  # ex: https://www.toptal.com/developers/gitignore/api/<language>
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$1
}

help() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: help command [args]"
    return 1
  fi
  
  local cmd="$1"
  shift
  
  if [[ "$@" == *"-h"* || "$@" == *"--help"* ]]; then
    # Command already has help flag, just run and pipe to bat
    $cmd "$@" 2>&1 | bat --plain --language=help
  else
    # Try --help first, if it fails try -h
    $cmd --help 2>&1 | bat --plain --language=help || \
    $cmd -h 2>&1 | bat --plain --language=help
  fi
}

