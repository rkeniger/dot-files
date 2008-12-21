export PATH="/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/:$PATH"
export PATH="/Library/PostgreSQL8/bin/:$PATH"     
export PATH="/usr/local/mysql/bin/:$PATH"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:~/.cabal/bin:$PATH

export PS1='\h:\W \u$(__git_ps1 " \[${COLOR_RED}\](%s)\[${COLOR_NC}\]")\$ '
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export EDITOR='/opt/local/bin/mate -w'
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR

# sets title of window to be user@host
# verifies you didn't use something that could've been an alias!
verify_not_alias() {
	last=`history 1`
	aliases=`alias`
	ruby ~/p/dot-files/verify.rb "$aliases" "$last"
}

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD}"; echo -ne "\007"; verify_not_alias' 

# Gem Doc
export GEMDIR=`gem env gemdir`
gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

# readline settings
bind "set completion-ignore-case on" 
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ ! -f ~/.dirs ]; then
	touch ~/.dirs
fi
save (){
	command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; 
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .dirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility
alias show='cat ~/.dirs'

# history (bigger size, no duplicates, always append):
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
