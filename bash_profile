###
### OSX-specific .bash_profile
###

### Source other bash files with specific/private setups
if [ -f ~/.affirm_specifics ] ; then source ~/.affirm_specifics; fi


### Source general (osx or linux) bash setup
[[ -f ~/.bash_includes ]] && source ~/.bash_includes

### Path
export HOME=~/code/fin-core-beta

### Aliases
alias bp="atom ~/.bash_profile"
alias bpi="atom ~/.bash_includes"
alias sc="source ~/.bash_profile"
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

### NB: Understand below

###
### Path-ey things
###
export PATH=$(pyenv root)/shims:/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:~/.ec2/bin

# generate ctags in different languages
# alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
# alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

### OSX-specific aliases
# run local mongodb (from /usr/local) and put it in the background
# alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
