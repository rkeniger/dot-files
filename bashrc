
# default path so if i reload i don't get slow downs
PATH=~/Library/haskell/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$PATH:~/.bin:/usr/texbin:~/bin
export PATH=$PATH

# For mercurial
export PYTHONPATH=/usr/local/lib/python2.5/site-packages:$PYTHONPATH

export APPENGINE_SDK_HOME=/opt/appengine-java-sdk-1.3.4

smiley_status() {
  if [ $? = 0 ]; then
    export SMILEY="\001\033[32m\002⚡\001\033[0m\002"
  else
    export SMILEY="\001\033[31m\002☢\001\033[0m\002"
  fi
}

#export PS1='$(hostname -s): \w $(__git_ps1 " \[${COLOR_RED}\](%s$(evil_git_dirty))\[${COLOR_NC}\]")\n$(echo -ne $SMILEY) '
export LESS="-R"
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export EDITOR='vim'
export GIT_EDITOR=$EDITOR
#export VISUAL="mate -r"
export JAVA_OPTS="-Dfile.encoding=UTF-8"

export RUBYOPT="rubygems"

verify_not_alias() {
	last=`history 1`
	aliases=`alias`
	ruby ~/Projects/dot-files/verify.rb "$aliases" "$last"
}

__git_ps1 () 
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf "(%s)" "${b##refs/heads/}";
    fi
}

function parse_git_branch {
       git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
}

function parse_git_dirty() {                                                                                                
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

function parse_git_stash() {
  local stash=`expr $(git stash list 2>/dev/null| wc -l)`

  if [ "$stash" != "0" ]; then
    echo "|stashed:$stash"
  fi
}

function git_prompt() {
  local ref="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3 -f4)"
  if [ "$ref" != "" ]; then
    echo "($ref$(parse_git_stash))"
  fi
}

export PS1='\[\e[0;31m\]$(hostname -s): \[\e[m\e[0;36m\]\w\[\e[m\e[0;32m\] $(git_prompt)\n$(echo -ne $SMILEY)\[\e[m\] '
#PS1="\e[0;31m\h \e[m\e[0;36m\w\e[m\e[0;32m \$(__git_ps1)\e[m$ "

function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo " *"
}


export PROMPT_COMMAND='smiley_status'
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"; verify_not_alias' 

#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"'

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
# Git completion
git_completion=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $git_completion ] ; then 
    source $git_completion;
    source /usr/local/etc/bash_completion.d/git-prompt.sh;
fi

# Brew Completion
brew_completion=`brew --prefix`/Library/Contributions/brew_bash_completion.sh
if [ -f $brew_completion ] ; then source $brew_completion; fi

#set -o vim
# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend



export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk

export ARCHFLAGS='-arch x86_64'