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

function update_neofetch_cache() {
    local cache_file="$HOME/.cache/neofetch_output"
    local update_interval=86400  # Update interval in seconds (e.g., 86400 for 1 day)

    # Function to get the current timestamp in a cross-platform way
    function current_timestamp() {
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            date +%s  # GNU/Linux
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            date -j -f "%a %b %d %T %Z %Y" "$(date)" "+%s"  # macOS
        else
            echo "Unsupported OS"
            exit 1
        fi
    }

    # Function to get the last modification time of the cache file
    function file_modification_timestamp() {
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            date +%s -r "$1"  # GNU/Linux
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            stat -f "%m" "$1"  # macOS
        else
            echo "Unsupported OS"
            exit 1
        fi
    }

    # Check if the cache file exists and is not too old
    if [[ ! -f "$cache_file" || $(( $(current_timestamp) - $(file_modification_timestamp "$cache_file") )) -gt $update_interval ]]; then
        neofetch > "$cache_file"
    fi

    cat "$cache_file"
}
