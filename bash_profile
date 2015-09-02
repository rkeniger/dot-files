source ~/.git-completion.bash
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors
export LSCOLORS="exfxcxdxbxegedabagacad"

source ~/.bashrc
source ~/.aliases.sh

#alias CC='/usr/local/bin/gcc-4.2'
#alias CC='/usr/bin/clang'
#alias CC=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/gcc-4.2
#alias CXX=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2
#alias CPP=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/cpp-4.2
#alias g++=/usr/local/Cellar/apple-gcc42/4.2.1-5666.3/bin/g++-4.2
export PATH="$HOME/.rbenv/bin:/usr/local/Cellar/ruby20/2.0.0-p481/bin:$PATH"
eval "$(rbenv init -)"

#export RBENV_ROOT=/usr/local/var/rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

