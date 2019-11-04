# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
ZSH_THEME="robbyrussell"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export PATH=~/.local/bin:$PATH


alias xc="xclip -selection c"
alias redis-local-keys="redis-cli -h redis.service.consul KEYS $1"
alias redis-local-keys-del="redis-cli -h redis.service.consul KEYS $1 | xargs redis-cli -h redis.service.consul DEL"

source <(kubectl completion zsh)

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

export EDITOR=nano

# The next line updates PATH for the Google Cloud SDK.  
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi  

# The next line enables shell command completion for gcloud. /
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi 

export DOTFILES=~/.dotfiles
export PATH=~/.dotfiles/bin:$PATH
export PATH=~/google-cloud-sdk/bin/:$PATH

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src