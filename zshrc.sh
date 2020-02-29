# check if this is a login shell
[ "$0" = "-zsh" ] && export LOGIN_ZSH=1

# run zprofile if this is not a login shell
[ -n "$LOGIN_ZSH" ] && source ~/.zprofile

# load shared shell configuration
source ~/.shrc

# History file
export HISTFILE=~/.zsh_history

# Don't show duplicate history entires
setopt hist_find_no_dups

# Remove unnecessary blanks from history
setopt hist_reduce_blanks

# Share history between instances
setopt share_history

# Don't hang up background jobs
setopt no_hup

# use emacs bindings even with vim as EDITOR
bindkey -e

# fix backspace on Debian
[ -n "$LINUX" ] && bindkey "^?" backward-delete-char

# fix delete key on macOS
[ -n "$MACOS" ] && bindkey '\e[3~' delete-char

# alternate mappings for Ctrl-U/V to search the history
bindkey "^u" history-beginning-search-backward
bindkey "^v" history-beginning-search-forward

export TERM="xterm-256color"
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="yellow"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="black"

zsh_wifi_signal(){
  local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
  local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

  if [ "$airport" = "Off" ]; then
          local color='%F{black}'
          echo -n "%{$color%}Wifi Off"
  else
          local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
          local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
          local color='%F{black}'

          [[ $speed -gt 100 ]] && color='%F{black}'
          [[ $speed -lt 50 ]] && color='%F{red}'

          echo -n "%{$color%}$speed Mbps \uf1eb%{%f%}" # removed char not in my PowerLine font
  fi
}

VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_VIRTUALENV_BACKGROUND='yellow'
POWERLEVEL9K_CUSTOM_PYTHON_VERSION_BACKGROUND='yellow'
POWERLEVEL9K_CUSTOM_PYTHON_VERSION='zsh_python_version'

zsh_python_version(){
  local output="$(python -V 2>&1)"
  echo " ${output:7}"
}


POWERLEVEL9K_CUSTOM_CONDA_ENVIRONMENT_BACKGROUND='yellow'
POWERLEVEL9K_CUSTOM_CONDA_ENVIRONMENT='zsh_conda_environment'
zsh_conda_environment(){
  if [[ ! -z "${CONDA_DEFAULT_ENV}" ]]; then
    echo "(ﬆ ${CONDA_DEFAULT_ENV})"
  fi
}

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_STAGES="▁▂▃▄▅▆▇█"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_VIRTUALENV_BACKGROUND='yellow'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context custom_python_version virtualenv_joined custom_conda_environment_joined dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time custom_wifi_signal ram disk_usage background_jobs)

#POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_TIME_FORMAT="%D{\ue005 %H:%M}" #\uf073 %d/%m/%y}"
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_RAM_BACKGROUND='yellow'
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="white"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_APPLE_ICON=''
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true






export PATH="/usr/local/opt/node@12/bin:$PATH"
