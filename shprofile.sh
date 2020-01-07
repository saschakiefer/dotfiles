# 077 would be more secure, but 022 is more useful.
umask 022

# Save more history
export HISTSIZE="100000"
export SAVEHIST="100000"

# OS variables
[ "$(uname -s)" = "Darwin" ] && export MACOS=1 && export UNIX=1
[ "$(uname -s)" = "Linux" ] && export LINUX=1 && export UNIX=1
uname -s | grep -q "_NT-" && export WINDOWS=1
grep -q "Microsoft" /proc/version 2>/dev/null && export UBUNTU_ON_WINDOWS=1

# Fix systems missing $USER
[ -z "$USER" ] && export USER="$(whoami)"

# Count CPUs for Make jobs
if [ $MACOS ]
then
  export CPUCOUNT="$(sysctl -n hw.ncpu)"
elif [ $LINUX ]
then
  export CPUCOUNT="$(getconf _NPROCESSORS_ONLN)"
else
  export CPUCOUNT=1
fi

if [ "$CPUCOUNT" -gt 1 ]
then
  export MAKEFLAGS="-j$CPUCOUNT"
  export BUNDLE_JOBS="$CPUCOUNT"
fi

# Enable Terminal.app folder icons
[ "$TERM_PROGRAM" = "Apple_Terminal" ] && export TERMINALAPP=1
if [ $TERMINALAPP ]
then
  set_terminal_app_pwd() {
    # Tell Terminal.app about each directory change.
    printf '\e]7;%s\a' "$(echo "file://$HOST$PWD" | sed -e 's/ /%20/g')"
  }
fi
[ -s ~/.lastpwd ] && [ "$PWD" = "$HOME" ] && \
  builtin cd "$(cat ~/.lastpwd)" 2>/dev/null
[ $TERMINALAPP ] && set_terminal_app_pwd

# Load secrets
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# Some post-secret aliases
export HOMEBREW_GITHUB_TOKEN="$GITHUB_TOKEN"
export HUBOT_GITHUB_TOKEN="$GITHUB_TOKEN"
export OCTOKIT_ACCESS_TOKEN="$GITHUB_TOKEN"

# Set stuff for the work Mac
if [ -e ~/.isWorkMac ]
then
    # export all_proxy="http://proxy.wdf.sap.corp:8080"
    # export http_proxy="http://proxy.wdf.sap.corp:8080"
    # export https_proxy="http://proxy.wdf.sap.corp:8080"
    # export no_proxy="localhost,127.0.0.0/8,*.local,*.sap.corp"
    # export ALL_PROXY="http://proxy.wdf.sap.corp:8080"
    # export HTTP_PROXY="http://proxy.wdf.sap.corp:8080"
    # export HTTPS_PROXY="http://proxy.wdf.sap.corp:8080"
    # export NO_PROXY="localhost,127.0.0.0/8,*.local,*.sap.corp"
fi

# Set Python Alias
# alias python=/usr/local/bin/python3 