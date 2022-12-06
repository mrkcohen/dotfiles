# Ensure home directory name is correct
export USER=$(whoami)
export ZSH="/Users/$USER/.oh-my-zsh"
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_label dir vcs newline
  # icons_test newline
  context virtualenv status
)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Set colors
# To see all the colors, run: for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
# POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_DIR_FOREGROUND='white'
POWERLEVEL9K_DIR_BACKGROUND='009' # dark-grey
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='007' # light-grey

# POWERLEVEL9K_VCS_BACKGROUND="10" # light/pastel green
POWERLEVEL9K_VCS_FOREGROUND='white'

# Customize the git icons/emojis
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'⚠️ '
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'‍🙅🏻‍'
POWERLEVEL9K_VCS_STAGED_ICON=$'🚀'

# Add a custom label icon prompt segment
POWERLEVEL9K_CUSTOM_LABEL="echo -n 💻 laptop"
POWERLEVEL9K_CUSTOM_LABEL_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_LABEL_BACKGROUND="017" # also like darkblue

# Context
POWERLEVEL9K_CONTEXT_BACKGROUND="white" # not working

# VirtualEnv
POWERLEVEL9K_VIRTUALENV_BACKGROUND="white"

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'

# Source/turn on Powerlevel9k
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# Misc
HISTFILESIZE=100000
HISTSIZE=10000

### Source other bash files with specific/private setups
if [ -f ~/.substack_imports ] ; then source ~/.substack_imports; fi
alias sscfg="atom ~/.substack_imports"

### Aliases
alias bp="atom ~/code/dotfiles/bash_profile"
alias bpi="atom ~/code/dotfiles/bash_includes"
alias sourcebp="source ~/.bash_profile"

alias zshconfig="atom ~/code/dotfiles/zshrc"
alias sourcezsh="source ~/.zshrc"

alias dot="cd ~/code/dotfiles"

### Docker aliases
alias dk='docker-compose'
alias dlogs='docker-compose logs -f --tail=50'
alias cslogs='docker-sync logs -f'

### Git
alias lsl='ls -G -lh --color=auto'
function lsp() { ls -lh $1 | egrep -v '.*.pyc$'; }
alias grep='grep -i --color=auto'
alias gg='git grep -n --color --heading --break'
alias .b='source ~/.bashrc && source ~/.bash_profile'
alias gd='git diff'
alias gr='git rebase origin/master'
alias gu='git add . && git ci --amend --no-edit'

function gmm() {
    local branch=$(current_branch)
    git checkout master
    git pull
    git checkout $branch
    git merge master
}

# gsr = Git Search Replace
function gsr() {
    search_string=$1
    replace_string=$2
    if [ -z $search_string ] || [ -z $replace_string ]
    then
        echo "-- Git Search & Replace (gsr)"
        echo "-- usage: gsr search_string replace_string"
    else
        git grep -l $search_string | xargs sed -i '' "s/$search_string/$replace_string/g"
        echo "Crushed it."
    fi
}

### This function prunes references to deleted remote branches and
### deletes local branches that have been merged and/or deleted from the remotes.
### It is intended to be run when on a master branch, and warns when it isn't.
function gclean (){
  local BRANCH=`git rev-parse --abbrev-ref HEAD`
  # Warning if not on a master* branch
  if [[ $BRANCH != master* ]]
  then
    echo -e "\e[91m!! WARNING: It looks like you are not on a master branch !!\e[39m"
    read -r -p "Are you sure you want to continue? [y/N] " response
    if ! [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      echo "Aborted. Nothing was changed."
      return 1
    fi
  fi
  echo "Simulating a clean on $BRANCH ..." \
  && echo "===== 1/2: simulating pruning origin =====" \
  && git remote prune origin --dry-run \
  && echo "===== 2/2: simulating cleaning local branches merged to $BRANCH =====" \
  && git branch --merged $BRANCH | grep -v "^\**\s*master"  \
  && echo "=====" \
  && echo "Simulation complete."
  read -r -p "Do you want to proceed with the above clean? [y/N] " response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
  then
    echo "Running a clean on $BRANCH ..."
    echo "===== 1/2: pruning origin =====" \
    && git remote prune origin \
    && echo "===== 2/2: cleaning local branches merged to $BRANCH =====" \
    && git branch --merged $BRANCH | grep -v "^\**\s*master" | xargs git branch -d \
    && echo "=====" \
    && echo "Clean finished."
  else
    echo "Aborted. Nothing was changed."
  fi
}

### git completion
fpath=(~/.zsh $fpath)

autoload -U compinit && compinit
zmodload -i zsh/complist

### ZSH Hooks
function load-nvmrc() {
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

function chpwd() {
  emulate -L zsh
  ls
}

add-zsh-hook chpwd load-nvmrc

###
### Path-ey things
###

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# Datacoral
if [[ ":$PATH:" != *":$HOME/.datacoral/cli/bin:"* ]];
then
  export PATH=$HOME/.datacoral/cli/bin:$PATH
fi

# Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/sbin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
