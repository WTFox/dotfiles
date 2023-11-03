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
  [ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
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

function ya() {
    tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
