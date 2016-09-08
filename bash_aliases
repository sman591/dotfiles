# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

############################################################
## Bash
############################################################

alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .2="cd ../../"
alias .3="cd ../../../"
alias .4="cd ../../../../"
alias .5="cd ../../../../../"
alias ~="cd ~"

alias c="clear"

alias path='echo -e ${PATH//:/\\n}'
alias ax="chmod a+x"

############################################################
## List
############################################################

if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi

alias l="ls"
alias ll="ls -lh"
alias la="ls -a"
alias lal="ls -alh"

############################################################
## Git
############################################################

alias g="git"
alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff"
alias gl="git pull --prune"
alias glr="git pull --rebase"
alias gf="git fetch --prune"
alias gp="git push"
alias gs="git status -sb"
alias gr="git remote"
alias grp="git remote prune"
alias gcp="git cherry-pick"
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gsu="git submodule update --init --recursive"
alias gi="git config branch.master.remote 'origin'; git config branch.master.merge 'refs/heads/master'"
if [ `which hub 2> /dev/null` ]; then
  alias git="hub"
fi
alias git-churn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"

# Useful report of what has been committed locally but not yet pushed to another
# branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $*
  fi
}

function gprune {
  local remote=$1
  if [ -z "$1" ]; then
    remote=origin
  fi
  local cmd="git remote prune $remote"
  echo $cmd
  $cmd
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status -sb
  fi
}

############################################################
## OS X
############################################################

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

############################################################
## Ruby
############################################################

alias rtags="ctags -e -R app lib vendor tasks"

function gemdir {
  echo `gem env gemdir`
}

function gemfind {
  local gems=`gemdir`/gems
  echo `ls $gems | grep -i $1 | sort | tail -1`
}

# Use: gemcd <name>, cd's into your gems directory
# that best matches the name provided.
function gemcd {
  cd `gemdir`/gems/`gemfind $1`
}

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open `gemdir`/doc/`gemfind $1`/rdoc/index.html
}

alias rhash="rbenv rehash"

############################################################
## Bundler
############################################################
function ignore_vendor_ruby {
  grep -q 'vendor/ruby' .gitignore > /dev/null
  if [[ $? -ne 0 ]]; then
    echo -e "\nvendor/ruby" >> .gitignore
  fi
}

alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
#alias binit="bi && bundle package"

############################################################
## Middleman
############################################################
alias m="be middleman"

############################################################
## Heroku
############################################################

function heroku_command {
  if [ -z "$*" ]; then
    echo "run console"
  else
    echo "$*"
  fi
}

function hstaging {
  heroku `heroku_command $*` --remote staging
}

function hproduction {
  heroku `heroku_command $*` --remote production
}

############################################################
## Rails
############################################################

alias tl="tail -f log/development.log"

# Rails 3
alias sr="script/rails"
alias src="sr console"

# Rails 3 or 4
function r {
  if [ -e "script/rails" ]; then
    script/rails $*
  else
    rails $* # Assumes rbenv-binstubs
  fi
}

############################################################
## MongoDB
############################################################
alias repair-mongo="rm /usr/local/var/mongodb/mongod.lock && mongod --repair"

############################################################
## Miscellaneous
############################################################

alias cs='ssh swo8127@georgia.cs.rit.edu'
alias v='vagrant'
alias t='gittower .'
alias s='subl '
alias kc='kubectl '

export GREP_COLOR="1;37;41"
alias grep="grep --color=auto"
alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias sha512="openssl dgst -sha512"
alias b64="openssl enc -base64"
alias 256color="export TERM=xterm-256color"
alias prettyjson="python -mjson.tool"

alias flushdns='dscacheutil -flushcache'

alias whichlinux='uname -a; cat /etc/*release; cat /etc/issue'

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

alias venv="source venv/bin/activate"

function serve {
  local port=$1
  : ${port:=3000}
  ruby -rwebrick -e"s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd, :MimeTypes => WEBrick::HTTPUtils::load_mime_types('/etc/apache2/mime.types')); trap(%q(INT)) { s.shutdown }; s.start"
}

function eachd {
  for dir in *; do
    cd $dir
    echo $dir
    $1
    cd ..
  done
}

function fakefile {
  let mb=$1
  let bytes=mb*1048576
  dd if=/dev/random of=${mb}MB-fakefile bs=${bytes} count=1 &> /dev/null
}

############################################################
