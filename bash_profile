export EDITOR="subl"

source /opt/boxen/env.sh

# FIXME
source /opt/boxen/homebrew/Cellar/git/1.8.0-boxen1/etc/bash_completion.d/git-completion.bash
source /opt/boxen/homebrew/Cellar/git/1.8.0-boxen1/share/git-core/contrib/completion/git-prompt.sh

PS1='$(date +%H:%M) \w$(__git_ps1 " (%s)")\$ '

# General
alias dds="find . -name '*.DS_Store' -type f -delete"
alias fdns='sudo dscacheutil -flushcache'
alias ls='ls -lahF'
alias o='open'
alias rb='source ~/.bash_profile'
alias s='subl'
alias sd='subl .'
alias sdf='subl ~/src/dotfiles'
alias ssc='subl ~/.ssh/config'
alias st='open http://0.0.0.0:8000 && python -m SimpleHTTPServer'
alias tre='tree -a -I .git'

# Gem Bundler
alias be='bundle exec'
alias bi='bundle install --without production'

# Git
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff | subl'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpl='git pull'
alias gps='git push'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs='git status -sb'

# Rails
alias dbm0='rake db:migrate VERSION=0'
alias dbm='rake db:migrate db:test:clone'
alias sc='if [ -f script/console ]; then script/console; else rails console; fi'
alias ss='./script/server'
alias tl='tail -f log/development.log'
alias ttl='tail -f log/test.log'
