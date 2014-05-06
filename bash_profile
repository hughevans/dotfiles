export EDITOR="subl"
export GIT_EDITOR="vim"

HISTFILESIZE=2000

source /opt/boxen/env.sh

# FIXME
source /opt/boxen/homebrew/Cellar/git/1.8.4-boxen2/etc/bash_completion.d/git-completion.bash
source /opt/boxen/homebrew/Cellar/git/1.8.4-boxen2/etc/bash_completion.d/git-prompt.sh

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

# https://gist.github.com/aliang/1024466
_complete_ssh_hosts ()
{
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
    cut -f 1 -d ' ' | \
    sed -e s/,.*//g | \
    grep -v ^# | \
    uniq | \
    grep -v "\[" ;
    cat ~/.ssh/config | \
    grep "^Host " | \
    awk '{print $2}'
  `
  COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
  return 0
}

complete -F _complete_ssh_hosts ssh

# https://gist.github.com/turadg/840663
function _rake_cache_path() {
  # If in a Rails app, put the cache in the cache dir
  # so version control ignores it
  if [ -e 'tmp/cache' ]; then
    prefix='tmp/cache/'
  fi
  echo "${prefix}.rake_t_cache"
}

function rake_cache_store() {
  rake --tasks --silent > "$(_rake_cache_path)"
}

function rake_cache_clear() {
  rm -f .rake_t_cache
  rm -f tmp/cache/.rake_t_cache
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

function _rakecomplete() {
  # error if no Rakefile
  if [ ! -e Rakefile ]; then
    echo "missing Rakefile"
    return 1
  fi

  # build cache if missing
  if [ ! -e "$(_rake_cache_path)" ]; then
    rake_cache_store
  fi

  local tasks=`awk '{print $2}' "$(_rake_cache_path)"`
  COMPREPLY=($(compgen -W "${tasks}" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake
