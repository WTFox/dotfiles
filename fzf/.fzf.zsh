# Setup fzf
# ---------
if [[ $OSTYPE == darwin* ]]; then
  # brew path
  fzf_path="/usr/local/opt/fzf/"
else 
  # linux standard path
  fzf_path="/home/wtfox/.fzf/"
fi

if [[ ! "$PATH" == *fzf_path* ]]; then
  export PATH="${PATH:+${PATH}:}${fzf_path}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${fzf_path}/shell/completion.zsh" 2> /dev/null


# Key bindings
# ------------
source "${fzf_path}/shell/key-bindings.zsh"
