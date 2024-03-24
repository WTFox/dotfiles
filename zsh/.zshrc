export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git gh extract zsh-autosuggestions zsh-syntax-highlighting fzf direnv poetry universalarchive urltools eza)
fpath=(/usr/local/share/zsh-completions $fpath)
source $ZSH/oh-my-zsh.sh

source $HOME/dotfiles/_bootstrap/os/common.sh
osType=$(get_os_type)
source $HOME/dotfiles/_bootstrap/os/${osType}.sh

[ -f ~/.exports.zsh ] && source ~/.exports.zsh
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh
[ -f ~/.functions.zsh ] && source ~/.functions.zsh

if [[ "$osType" == "mac" ]]; then
  [ -f ~/.aliases_mac.zsh ] && source ~/.aliases_mac.zsh
  [ -f ~/.exports_mac.zsh ] && source ~/.exports_mac.zsh
  [ -f ~/.functions_mac.zsh ] && source ~/.functions_mac.zsh
	else
  [ -f ~/.aliases_linux.zsh ] && source ~/.aliases_linux.zsh
  [ -f ~/.exports_linux.zsh ] && source ~/.exports_linux.zsh
  [ -f ~/.functions_linux.zsh ] && source ~/.functions_linux.zsh
fi

# pc-specific files that are git-ignored:
[ -f ~/.personal.zsh ] && source ~/.personal.zsh
[ -f ~/.work.zsh ] && source ~/.work.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# update_neofetch_cache

greet() {
    QUOTE_FILE=~/.config/misc/quotes.json

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
    YELLOW='\033[1;33m'

    WIDTH=$(tput cols)
    print_centered() {
        TEXT="$1"
        COLOR="$2"
        WRAPPED_TEXT=$(echo -e "$TEXT" | fold -w $((WIDTH * 0.6)) -s)
        while IFS= read -r LINE; do
            TEXT_LENGTH=$(echo -n "$LINE" | sed 's/\x1b\[[0-9;]*m//g' | wc -m)
            SPACES=$(( (WIDTH - TEXT_LENGTH) / 2 ))
            printf "%${SPACES}s" ""
            echo -e "${COLOR}${LINE}${NC}"
        done <<< "$WRAPPED_TEXT"
    }

    DATE_TIME="$(date "+%Y-%m-%d @ %I:%M %p")"
    NUM_QUOTES=$(jq '. | length' $QUOTE_FILE)
    RANDOM_INDEX=$((RANDOM % NUM_QUOTES))
    QUOTE_CONTENT=$(jq -r --argjson index $RANDOM_INDEX '.[$index] | .content' $QUOTE_FILE)
    QUOTE_AUTHOR=$(jq -r --argjson index $RANDOM_INDEX '.[$index] | .author' $QUOTE_FILE)
    QUOTED_CONTENT="\"${QUOTE_CONTENT}\""

    print_centered "" ""
    print_centered "$QUOTED_CONTENT" "$BLUE"
    print_centered "" ""
    print_centered "- $QUOTE_AUTHOR" "$YELLOW"
    print_centered "" ""
    print_centered "$DATE_TIME" "$GREEN"
}

greet
