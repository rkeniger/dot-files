export PATH="/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/:$PATH"
export PATH="/Library/PostgreSQL8/bin/:$PATH"     
export PATH="/usr/local/mysql/bin/:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:~/.cabal/bin:$PATH
export PATH=/opt/iphone/bin:$PATH
export PATH=/opt/scala/bin:$PATH
export PATH=~/.gem/ruby/1.8/bin:$PATH
# For mercurial
export PYTHONPATH=/usr/local/lib/python2.5/site-packages:$PYTHONPATH


smiley_status() {
  if [ $? = 0 ]; then
    export SMILEY="\001\033[32m\002⚡\001\033[0m\002"
  else
    export SMILEY="\001\033[31m\002☢\001\033[0m\002"
  fi
}

export PS1='\w $(__git_ps1 " \[${COLOR_RED}\](%s)\[${COLOR_NC}\]")\n$(echo -ne $SMILEY) ∴ '
export LESS="-R"
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export EDITOR='~/bin/mate -w'
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR``
export JAVA_OPTS="-Dfile.encoding=UTF-8"

export RUBYOPT="rubygems"

verify_not_alias() {
	last=`history 1`
	aliases=`alias`
	ruby ~/p/dot-files/verify.rb "$aliases" "$last"
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

. /usr/local/git/contrib/completion/git-completion.bash

# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
