# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


# SHELL CONFIGURATION
# ===================
plugins=(git ruby golang django scala gem history history-substring-search terminalapp brew nanoc)

bindkey "\e0A" up-line-or-history
bindkey "\eOB" down-line-or-history
bindkey "\eOC" forward-char
bindkey "\eOD" backward-char

set -o vi
# Aggregate history across sessions
setopt APPEND_HISTORY

# PATH
# ====

source $ZSH/oh-my-zsh.sh
# Use Homebrew binaries
export PATH=/usr/local/bin:$PATH
# Add LilyPond binaries to path
export PATH=$PATH:/Applications/LilyPond.app/Contents/Resources/bin
# Add python executables to the path
export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin

# ENV VARIABLES
# =============
source ~/.secrets
PROMPT="$PROMPT"$'\n'"🐌  "

# ALIASES
# =======

alias dev='cd /Users/$USER/dev/$@'
alias logcheck='cd /Users/$USER/dev/logcheck/logcheck-web/$@'
alias dotfiles='cd /Users/$USER/dotfiles/$@'
alias blog='cd /Users/$USER/dev/blog/$@'
alias vim_prac='cd /Users/$USER/dev/practice/vim/$@'
alias typing='cd /Users/$USER/dev/practice/typing/$@'

# FUNCTIONS
# =========

function logcheck_ember {
  cd /Users/${USER}/dev/logcheck/logcheck-web/app/assets/javascripts/ember_code
}

function ack_sub {
  ack -l $1 $3 | xargs perl -pi -E 's/'$1'/'$2'/gc'
}

function ack_capture {
  ack -l $1 | echo $1
}

function rg {
  rake routes | grep $1
}

function fs {
  foreman start
}

function rc {
  rails console
}

function rp {
  pry-remote
}

function mysql_sock() {
  mysqladmin variables | grep socket
}

alias ls="ls -lah"

# provides a convenient way to figure out which PID is listening on a particular port
alias lsof="lsof -n -P -i"

alias bx='bundle exec'

# GIT
# ===

alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git status'
alias gbl='git branch --list'
alias gbm='git branch -m'
alias gcm='git checkout master'

# Prune merged branches
function gpm {
  git branch --merged | grep -v "\*" | grep -v "master" | xargs git branch -d
}

# MacPorts
# ========
# adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Users/michaelprouty/Library/Python/2.7/bin:$PATH"

# RVM
# ===
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scription

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# PYTHON
# ======
export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"

# Android Studios
# ===============
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Yarn
# ====
export PATH="$(yarn global bin):$PATH"

# NVM
# ===
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load node version from .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
