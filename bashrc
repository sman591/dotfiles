## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

export GOPATH=$HOME/dev/go
export KUBECONFIG=$HOME/dev/coreos/dev-cluster/kubeconfig

function conditionally_prefix_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

conditionally_prefix_path /usr/local/bin
conditionally_prefix_path /usr/local/sbin
conditionally_prefix_path /usr/local/share/npm/bin
conditionally_prefix_path /usr/local/mysql/bin
conditionally_prefix_path /usr/local/heroku/bin
conditionally_prefix_path /usr/texbin
conditionally_prefix_path ~/bin
conditionally_prefix_path ~/bin/private
conditionally_prefix_path $GOPATH/bin

PATH=.:./bin:${PATH}

############################################################
## MANPATH
############################################################

function conditionally_prefix_manpath {
  local dir=$1
  if [ -d $dir ]; then
    MANPATH="$dir:${MANPATH}"
  fi
}

conditionally_prefix_manpath /usr/local/man
conditionally_prefix_manpath ~/man

############################################################
## Other paths
############################################################

function conditionally_prefix_cdpath {
  local dir=$1
  if [ -d $dir ]; then
    CDPATH="$dir:${CDPATH}"
  fi
}

conditionally_prefix_cdpath ~/dev

CDPATH=.:${CDPATH}

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi

############################################################
## General development configurations
###########################################################

if [ `which rbenv 2> /dev/null` ]; then
  eval "$(rbenv init -)"
fi

if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

export RBXOPT=-X19

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

if [ `which git 2> /dev/null` ]; then
  function git_prompt {
    parse_git_branch
  }
else
  function git_prompt {
    echo ""
  }
fi

if [ `which rbenv 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(rbenv version-name)
  }
elif [ `which ruby 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(ruby --version | cut -d' ' -f2)
  }
else
  function ruby_prompt {
    echo "_"
  }
fi

if [ `which nodenv 2> /dev/null` ]; then
  function node_prompt {
    echo $(nodenv version-name)
  }
elif [ `which node 2> /dev/null` ]; then
  function node_prompt {
    echo $(node --version | cut -d' ' -f2)
  }
else
  function node_prompt {
    echo "_"
  }
fi

if [ -n "$BASH" ]; then
  export PS1='\[\033[32m\]\n> \s: \w \[\033[91m\]$(ruby_prompt)\[\033[32m\] \[\033[95m\]$(node_prompt)\[\033[32m\] $(git_prompt)\n\[\033[31m\]> \u@\h\$ \[\033[00m\]'
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="subl -n -w"

############################################################
## History
############################################################

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend

export HISTIGNORE="&:pwd:ll:[bf]g:exit"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=erasedups
# increase the default size from only 1,000 items
export HISTSIZE=10000

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
elif [ -e ~/.bash_completion ]; then
  # Fallback. This should be sourced by the above scripts.
  . ~/.bash_completion
fi

############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

function git-trim() {
  if [ -z "$1" ]
  then
    branch="master"
  else
    branch=$1
  fi
  git branch --merged $branch | grep -v $branch | xargs -n 1 git branch -d
  echo ""
  git branch
}

# boot2docker
eval `boot2docker shellinit 2>/dev/null`

############################################################
## Ruby Performance Boost (see https://gist.github.com/1688857)
############################################################

export RUBY_GC_MALLOC_LIMIT=60000000
# export RUBY_FREE_MIN=200000 # Ruby <= 2.0
export RUBY_GC_HEAP_FREE_SLOTS=200000 # Ruby >= 2.1

# added by travis gem
[ -f /Volumes/Monster/Users/stuart/.travis/travis.sh ] && source /Volumes/Monster/Users/stuart/.travis/travis.sh
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export COCOAPODS_NO_BUNDLER=1
