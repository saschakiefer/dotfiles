# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# My path extensions
export PATH=~/Library/Python/3.9/bin:/usr/local/opt/python@3.9/bin:$PATH:$HOME/.poetry/bin

# Aliases
alias mkdir="mkdir -vp"
alias df="df -H"
alias rm="rm -iv"
alias mv="mv -iv"
alias zmv="noglob zmv -vW"
alias cp="cp -irv"
alias du="du -sh"
alias make="nice make"
alias less="less --ignore-case --raw-control-chars"
alias rsync="rsync --partial --progress --human-readable --compress"
alias rake="noglob rake"
alias rg="rg --colors 'match:style:nobold' --colors 'path:style:nobold'"
alias be="noglob bundle exec"
alias sha256="shasum -a 256"
alias ...="cd .."
alias lsd="lsd -al"

export GREP_OPTIONS="--color=auto"

# fix delete key on macOS
bindkey '\e[3~' delete-char

# History file
export HISTFILE=~/.zsh_history

# Don't show duplicate history entires
setopt hist_find_no_dups

# Remove unnecessary blanks from history
setopt hist_reduce_blanks

# Share history between instances
setopt share_history

# alternate mappings for Ctrl-U/V to search the history
bindkey "^u" history-beginning-search-backward
bindkey "^v" history-beginning-search-forward

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    brew
    colored-man-pages
    copydir
    copyfile
    dirpersist
    docker
    git
    git-open
    kubectl
    last-working-dir
    osx
    ssh-agent
    zsh-autosuggestions
    zsh-syntax-highlighting
    genpass
 )

# Setup ssh-agent
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_sap

source $ZSH/oh-my-zsh.sh

# Syntax Highlighter
ZSH_HIGHLIGHT_STYLES[path]='none'

# Auto Suggest Style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6f7070"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
  export GIT_EDITOR="$EDITOR -w"
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Modify the agnoster Theme
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PRIMARY_FG=black

prompt_context() {}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}\n>>>"
  CURRENT_BG=''
}

# Display current virtual environment
prompt_virtualenv() {
  local output="$(python -V 2>&1)"
  color=yellow
  prompt_segment $color $PRIMARY_FG
  print -Pn " ${output:7}"

  if [[ -n $VIRTUAL_ENV ]]; then
    local sub="$(echo $(basename $VIRTUAL_ENV) | awk -F "-" '{print $NF}' 2>&1)" # get suffix
    local output=$(echo ${$(basename $VIRTUAL_ENV)/-$sub/''} 2>&1) # replace -suffix w/ ''
    print -Pn " ≡ ${output} "
  fi
}

if [ -e ~/.isWorkMac ]
then
  . "/Users/d044813/.acme.sh/acme.sh.env"
  export PATH="$PATH:/Users/d044813/Applications/shell-tools"

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/d044813/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/d044813/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/Users/d044813/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/Users/d044813/opt/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.7.2
else
  . "/Users/saschakiefer/.acme.sh/acme.sh.env"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export KUBECONFIG=$HOME/.kube/config

# # Java
# export JAVA_16_HOME=$(/usr/libexec/java_home -v16)
# export JAVA_11_HOME=$(/usr/libexec/java_home -v11)

# alias java16='export JAVA_HOME=$JAVA_16_HOME'
# alias java11='export JAVA_HOME=$JAVA_11_HOME'

# # default to Java 11
# java11

# export PATH="$JAVA_HOME/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ -e ~/.isWorkMac ]
then
  export SDKMAN_DIR="/Users/d044813/.sdkman"
  [[ -s "/Users/d044813/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/d044813/.sdkman/bin/sdkman-init.sh"
else
  export SDKMAN_DIR="/Users/saschakiefer/.sdkman"
  [[ -s "/Users/saschakiefer/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/saschakiefer/.sdkman/bin/sdkman-init.sh"
fi
