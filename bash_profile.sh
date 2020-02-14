# load shared shell configuration
source ~/.shprofile

# check if this is a login and/or interactive shell
[ "$0" = "-bash" ] && export LOGIN_BASH=1
echo "$-" | grep -q "i" && export INTERACTIVE_BASH=1

# run bashrc if this is a login, interactive shell
if [ -n "$LOGIN_BASH" ] && [ -n "$INTERACTIVE_BASH" ]
then
  source ~/.bashrc
fi

# Set HOST for ZSH compatibility
export HOST="$HOSTNAME"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# Save multiline commands
shopt -s cmdhist

# Correct minor directory changing spelling mistakes
shopt -s cdspell

# Bash completion
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion
[ -d "$HOMEBREW_PREFIX/etc/bash_completion.d" ] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/*" >/dev/null

# Git branch parser
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

# Colorful prompt
# RED="\[\033[0;31m\]"
# YELLOW="\[\033[0;33m\]"
# GREEN="\[\033[0;32m\]"
# GREY="\[\033[0;37m\]"

# if [ "$USER" = "root" ]
# then
#   PS1="$GREEN\u@\h \w $YELLOW\$(parse_git_branch)$GREY\$ "
# elif [ -n "${SSH_CONNECTION}" ]
# then
#   PS1="$GREEN\u@\h \w $YELLOW\$(parse_git_branch)$GREY\$ "
# else
#   PS1="$GREEN\u@\h \w $YELLOW\$(parse_git_branch)$GREY\$ "
# fi

# Aliases
# alias ...="cd .."

# only set key bindings on interactive shell
if [ -n "$INTERACTIVE_BASH" ]
then
  # fix delete key on macOS
  [ "$MACOS" ] && bind '"\e[3~" delete-char'

  # alternate mappings for Ctrl-U/V to search the history
  bind '"^u" history-search-backward'
  bind '"^v" history-search-forward'
fi

