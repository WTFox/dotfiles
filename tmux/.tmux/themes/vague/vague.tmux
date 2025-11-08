#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Available themes
declare -A themes=(
  ["vague"]="vague.tmuxtheme"
)

# Tmux options
# @vague_flavour default is "vague"
# @vague_date_format default is "%Y-%m-%d"
# @vague_time_format default is "%H:%M"
# @vague_show_battery default is "off"
# @vague_battery_icon default is "🔋"
# @vague_show_user default is "on"
# @vague_show_host default is "on"
# @vague_show_window_flags default is "off"
# @vague_status_modules_right default is "battery date"
# @vague_left_separator default is ""
# @vague_right_separator default is ""
# @vague_left_subseparator default is ""
# @vague_right_subseparator default is ""

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

setw() {
  local option=$1
  local value=$2
  tmux set-window-option -gq "$option" "$value"
}

main() {
  local vague_flavour=$(get_tmux_option "@vague_flavour" "vague")

  if [[ ! -z "${themes[$vague_flavour]}" ]]; then
    source "${CURRENT_DIR}/${themes[$vague_flavour]}"
  else
    echo "Invalid flavour: $vague_flavour. Using default vague theme."
    source "${CURRENT_DIR}/vague.tmuxtheme"
  fi

  # Status options
  set "status" "on"
  set "status-justify" "left"
  set "status-position" "bottom"
  set "status-left-length" "100"
  set "status-right-length" "100"
  set "status-style" "fg=$thm_fg,bg=$thm_bg"

  # Messages
  set "message-style" "fg=$thm_cyan,bg=$thm_bg"
  set "message-command-style" "fg=$thm_cyan,bg=$thm_bg"

  # Panes
  set "pane-border-style" "fg=$thm_border"
  set "pane-active-border-style" "fg=$thm_active_border"
  set "display-panes-colour" "$thm_gray"
  set "display-panes-active-colour" "$thm_highlight"

  # Clock
  setw "clock-mode-colour" "$thm_accent"
  setw "clock-mode-style" "24"

  # Get formatting options
  local left_separator=$(get_tmux_option "@vague_left_separator" "")
  local right_separator=$(get_tmux_option "@vague_right_separator" "")
  local left_subseparator=$(get_tmux_option "@vague_left_subseparator" "")
  local right_subseparator=$(get_tmux_option "@vague_right_subseparator" "")
  local show_battery=$(get_tmux_option "@vague_show_battery" "off")
  local battery_icon=$(get_tmux_option "@vague_battery_icon" "🔋")
  local date_format=$(get_tmux_option "@vague_date_format" "%Y-%m-%d")
  local time_format=$(get_tmux_option "@vague_time_format" "%H:%M")
  local show_user=$(get_tmux_option "@vague_show_user" "on")
  local show_host=$(get_tmux_option "@vague_show_host" "on")
  local show_flags=$(get_tmux_option "@vague_show_window_flags" "off")
  local session_icon=$(get_tmux_option "@vague_session_icon" "󰝘")
  local window_icon=$(get_tmux_option "@vague_window_icon" "󱂬")
  local pane_icon=$(get_tmux_option "@vague_pane_icon" "")
  local status_modules_right=$(get_tmux_option "@vague_status_modules_right" "battery date")

  # Windows style
  setw "window-status-style" "fg=$thm_gray,bg=$thm_bg"
  setw "window-status-format" "#[fg=$thm_bg,bg=$thm_statusline_bg]$left_separator#[fg=$thm_gray,bg=$thm_statusline_bg] $window_icon #I $left_subseparator #W #[fg=$thm_statusline_bg,bg=$thm_bg]$right_separator"

  # Current window style with flags if enabled
  local current_format=" $window_icon #I $left_subseparator #W "
  if [[ "$show_flags" == "on" ]]; then
    current_format="$current_format#F "
  fi

  setw "window-status-current-style" "fg=$thm_fg,bg=$thm_statusline_bg,bold"
  setw "window-status-format" "#[fg=$thm_statusline_bg,bg=$thm_bg]$left_separator#[fg=$thm_gray,bg=$thm_statusline_bg] $window_icon #I $left_subseparator #W #[fg=$thm_statusline_bg,bg=$thm_bg]$right_separator"
  setw "window-status-current-format" "#[fg=$thm_accent,bg=$thm_bg]$left_separator#[fg=$thm_total_black,bg=$thm_accent,bold] $window_icon #I $left_subseparator #W #[fg=$thm_accent,bg=$thm_bg]$right_separator"

  setw "window-status-activity-style" "fg=$thm_warning,bg=$thm_bg"
  setw "window-status-bell-style" "fg=$thm_error,bg=$thm_bg"
  setw "window-status-separator" ""

  # Status left - Session info
  local status_left="#[fg=$thm_total_black,bg=$thm_accent,bold] $session_icon #S #[fg=$thm_accent,bg=$thm_statusline_bg]$right_separator"

  # User and host info
  if [[ "$show_user" == "on" ]]; then
    username=$(whoami)
    status_left="$status_left #[fg=$thm_fg,bg=$thm_statusline_bg]$username"
  fi

  if [[ "$show_host" == "on" ]]; then
    if [[ "$show_user" == "on" ]]; then
      status_left="$status_left #[fg=$thm_fg,bg=$thm_statusline_bg]$left_subseparator"
    fi
    hostname=$(hostname -s)
    status_left="$status_left #[fg=$thm_fg,bg=$thm_statusline_bg]$hostname"
  fi

  # End of status left
  status_left="$status_left #[fg=$thm_statusline_bg,bg=$thm_bg]$right_separator"

  set "status-left" "$status_left"

  # Status right
  local status_right="#[fg=$thm_statusline_bg,bg=$thm_bg]$left_separator#[fg=$thm_fg,bg=$thm_statusline_bg]"

  # Add modules
  local first_module=true
  for module in $status_modules_right; do
    if [[ "$first_module" == "false" ]]; then
      status_right="$status_right $right_subseparator "
    fi
    first_module=false

    case $module in
    battery)
      if [[ "$show_battery" == "on" ]]; then
        status_right="$status_right $battery_icon #{battery_percentage}"
      fi
      ;;
    date)
      status_right="$status_right $(date +"$date_format")"
      ;;
    time)
      status_right="$status_right $(date +"$time_format")"
      ;;
    esac
  done

  # End of status right with pane info
  status_right="$status_right #[fg=$thm_accent,bg=$thm_statusline_bg]$left_separator#[fg=$thm_total_black,bg=$thm_accent,bold] $pane_icon #P "

  set "status-right" "$status_right"
}

main
