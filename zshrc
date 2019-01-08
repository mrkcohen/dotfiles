# Ensure home directory name is correct
export ZSH="/Users/michael/.oh-my-zsh"
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_fin dir vcs newline
  # icons_test newline
  status
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

POWERLEVEL9K_DIR_FOREGROUND="white"

# Add the custom Fin icon prompt segment
POWERLEVEL9K_CUSTOM_FIN="echo -n '\uF68B' fin"
POWERLEVEL9K_CUSTOM_FIN_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_FIN_BACKGROUND="017" # also like darkblue

# Customize the git icons/emojis
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'⚠️ '
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'🙅🏻‍♂️'
POWERLEVEL9K_VCS_STAGED_ICON=$'🚀'

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'

# Source/turn on Powerlevel9k
# source  ~/powerlevel9k/powerlevel9k.zsh-theme
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# Misc
HISTFILESIZE=100000
HISTSIZE=10000

### Source other bash files with specific/private setups
if [ -f ~/.fin_profile_secrets ] ; then source ~/.fin_profile_secrets; fi
alias fps="atom ~/.fin_profile_secrets"

### Aliases
alias bp="atom ~/.bash_profile"
# alias bps="atom ~/.bash_profile_secrets"
alias bpi="atom ~/.bash_includes"
alias sourcebp="source ~/.bash_profile"

alias zshconfig="atom ~/.zshrc"
alias sourcezsh="source ~/.zshrc"

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

### git completion
fpath=(~/.zsh $fpath)

autoload -U compinit && compinit
zmodload -i zsh/complist

### aws completion
# source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh

### Imported from bash_profile

### Setup Fin to work via Alfred
### https://github.com/kortina/fin-alfred
# export FIN_FROM_EMAIL="mrkcohen@gmail.com"
# export FIN_TO_EMAIL="mike.cohen@fin.com" # ask Fin for this if you don't know it
# export FIN_ALFRED_LOG="/dev/null"

### Datacoral
# if [[ ":$PATH:" != *":$HOME/.datacoral/cli/bin:"* ]];
# then
#   export PATH=$HOME/.datacoral/cli/bin:$PATH
# fi

### TODO: Understand the below better

###
### Path-ey things
###
# the classic MySQL library path fix for OSX  (un-comment if installing mysql)
# export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
# export PATH=/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:~/.ec2/bin

# VirtualEnvWrapper
# export WORKON_HOME=~/virtualenvs
# if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then source /usr/local/bin/virtualenvwrapper.sh; fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; else echo pyenv not installed; fi

# go path
# export GOPATH=$HOME/go

# generate ctags in different languages
# alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
# alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

# EC2 Command Line Tools - not really using recently
# export JAVA_HOME="`/usr/libexec/java_home -v 1.6`"
# export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
# export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
# export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"


### OSX-specific aliases
# run local mongodb (from /usr/local) and put it in the background
# alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'


### NPM Module common scripts
alias karma='./node_modules/karma/bin/karma'
alias karmaone='./node_modules/karma/bin/karma start --singleRun --browsers PhantomJS'

# added by Anaconda2 4.3.1 installer
# export PATH="/anaconda/bin:$PATH"
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
