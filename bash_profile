###
### OSX-specific .bash_profile
###
HISTFILESIZE=100000000
HISTSIZE=100000

### Source general (osx or linux) bash setup
[[ -f ~/.bash_includes ]] && source ~/.bash_includes

### Source other bash files with specific/private setups
if [ -f ~/.bash_profile_secrets ] ; then source ~/.bash_profile_secrets; fi

### Fin path
export FIN_HOME=~/code/fin-core-beta
export FIN_SSH_USERNAME="mike_cohen"
source "${FIN_HOME}/fin-dev/bashrc"

### Aliases
alias bp="atom ~/.bash_profile"
alias bps="atom ~/.bash_profile_secrets"
alias bpi="atom ~/.bash_includes"
alias sc="source ~/.bash_profile"

### Fin aliases
alias dk='docker-compose'
alias dlogs='docker-compose logs -f --tail=50'
alias cslogs='docker-sync logs -f'

### brew bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

### aws completion
if [ -f `brew --prefix`/bin/aws_completer ]; then
complete -C aws_completer aws
fi

### git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

### Setup Fin to work via Alfred
### https://github.com/kortina/fin-alfred
export FIN_FROM_EMAIL="mrkcohen@gmail.com"
export FIN_TO_EMAIL="mike.cohen@fin.com" # ask Fin for this if you don't know it
export FIN_ALFRED_LOG="/dev/null"

### Datacoral
if [[ ":$PATH:" != *":$HOME/.datacoral/cli/bin:"* ]];
then
  export PATH=$HOME/.datacoral/cli/bin:$PATH
fi

### NB: Understand below

###
### Path-ey things
###
# the classic MySQL library path fix for OSX  (un-comment if installing mysql)
# export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:~/.ec2/bin

# VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then source /usr/local/bin/virtualenvwrapper.sh; fi

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; else echo pyenv not installed; fi

# go path
export GOPATH=$HOME/go

# generate ctags in different languages
alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

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
export PATH="/anaconda/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
