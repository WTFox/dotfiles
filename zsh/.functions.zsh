function load_pyenv() {
  if type pyenv > /dev/null 2>&1; then
      return
  fi
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

nvm() {
    unset -f nvm
    [ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh" --no-use
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    nvm "$@"
}

# function load_nvm() {
#   if type nvm > /dev/null 2>&1; then
#       return
#   fi
#   export NVM_DIR="$HOME/.nvm"
#
#   [ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# }

# Auto-attach to existing tmux session, or create one if none exist
tmux() {
    if [[ $# -eq 0 ]]; then
        # No arguments - attach to existing session or create new
        command tmux attach 2>/dev/null || command tmux new-session
    else
        command tmux "$@"
    fi
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

m4bchapters() {
  # Usage: m4bchapters <audiofile> [min_silence_sec] [noise_dB]
  # Writes <basename>.chapters.txt (OGM/Audiobook-style) to the current dir.
  local infile="$1"
  local mindur="${2:-1.5}"       # min silence length in seconds to count as a break
  local noise="${3:--30}"        # dB threshold; lower (e.g. -40) catches quieter gaps

  if [[ -z "$infile" || ! -f "$infile" ]]; then
    echo "usage: m4bchapters <audiofile> [noise_dB] [min_silence_sec]" >&2
    return 1
  fi

  local base="${infile##*/}"; base="${base%.*}"
  local out="./${base}.chapters.txt"

  ffmpeg -nostdin -hide_banner -i "$infile" \
    -af "silencedetect=noise=${noise}dB:d=${mindur}" -f null - 2>&1 \
  | awk '
      /silence_end/ {
        for (i=1; i<=NF; i++) if ($i=="silence_end:") t=$(i+1)
        print t
      }
    ' \
  | python3 -c '
import sys
starts = [0.0] + [float(x) for x in sys.stdin.read().split()]
def ts(s):
    h=int(s//3600); m=int((s%3600)//60); sec=s%60
    return f"{h:02d}:{m:02d}:{sec:06.3f}"
for i,s in enumerate(starts,1):
    print(f"CHAPTER{i:02d}={ts(s)}")
    print(f"CHAPTER{i:02d}NAME=Chapter {i}")
  ' > "$out"

  echo "wrote $out ($(grep -c "^CHAPTER[0-9]*=" "$out") chapters)" >&2
  cat "$out"
}
