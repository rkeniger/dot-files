alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lah'
alias ..='cd ..;'
alias ...='.. ..'
alias ducks='du -cks * | sort -rn|head -11' # Lists the size of all the folders$
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias du1="du  -hd1"
alias mate="mate -r"
alias vi="vim"
alias kf="killall Finder"
alias svnig="svn propedit svn:ignore"
alias ka="killall"
alias o="open -R"
alias kax="ka Xcode"
alias glat="git --no-pager log -n3"
alias r='rake'
alias rvm='CC=/usr/bin/gcc-4.2 rvm'

alias fjson="python -mjson.tool"
alias safari_curl='curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2"'

# = Kit Related =
alias k="kit"
alias ku="rm -rdf build Kits ~/.kit/packages/*; kit update"
alias clear-kit="mv ~/.kit/packages ~/.Trash/"

alias qlp="qlmanage -p"
alias s="screen"
alias dfh="df -h"
alias xcwhich="xcode-select -print-path; xcodebuild -version"
# remove Derived Data
alias ddd="rm -rdf /Users/rob/Library/Developer/Xcode/DerivedData"

alias xcb="xcodebuild -jobs 8"
alias xcb-debug="time xcodebuild -jobs 8 -configuration Debug"
alias xcb-qa='xcodebuild -configuration "Ad Hoc QA"'
alias goo="go oompf-ipad"
alias fuckingnetwork="networksetup -setairportpower  en1 off ; sleep 3; networksetup -setairportpower en1 on"

function editprofile() {
	if [[ $# -gt 0 ]]; then
		mate -w $1 
		. ~/.bash_profile
	else	
		echo "Please Supply a file name"
		return -1
	fi
}
function repeter() {
    yes "$*" | xargs say
}
function lookfor() {
  grep -EiIrl "$*" ./* | grep -v '.svn'
}

function gtow() {
  go
  git clone $1 $2 && gittower $2
}
removeduplines() {
awk '{
if ($0 in stored_lines)
   x=1
else
   print
   stored_lines[$0]=1
}' $1  
}

# Symlink kit as a dev-package
function link-kit() {
	PROJECT_DIRS="$HOME/Projects"
	DPK="dev-packages"
	if [[ -f "KitSpec" ]]; then		
		RES=`find $PROJECT_DIRS -iname "${1}*" -maxdepth 1 | head -n 1`
		if [[ "$RES" == "" ]]; then
			echo  "Couldn't find '$1' in $HOME/Projects/"
			return 1
		elif [[ -f "$RES/KitSpec" ]]; then
			mkdir -p $DPK
 			cd $DPK
			ln -s $RES $(basename $RES)
			cd ..
			echo "Linked Package $RES"
            kit up
			return 0
		else
			echo "$RES isn't a kit"
		fi
	else
		echo "$(pwd) isn't a kit"
		return 1
	fi
}
function h() {
  hoogle --color --count=30 ${1} 
}

# useful command to find what you should be aliasing:
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias pp="cd ~/Library/MobileDevice/Provisioning\ Profiles"


function to_ipod() {
   VAL="HandBrakeCLI -i ${1} -o ${1}.mp4 --preset=\"iPhone & iPod Touch\""
   echo $VAL
   sh -c $VAL
}

function fill_file() {
  let A=1024*1024
	dd if=/dev/zero of=filefile${2}.filler bs=$A count=$1 seek=0
  echo creating file of size ${1}mb
}

alias gl='git smp'

alias gs='git status -sb'
alias glr='git pull --rebase'
alias glg='git log --oneline --decorate'
alias gsu='git submodule update'

alias gp='git push'
alias gpa='git push-all' # see [alias] in ~/.gitconfig
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -v'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gm='git smart-merge'
alias gcm='git commit -v -m'
alias gbd='git branch -d'

# 
# alias gitx="open -b nl.frim.GitX"
# alias gm='git merge --no-ff'
alias gfo='git fetch origin'
# alias grb='git rebase'
# alias gdi='git diff --staged'
alias gd='git diff'
# 
# alias m=mvim
# 
alias ox="xcselect -o"

alias ea='mvim -f ~/.aliases.sh && source ~/.aliases.sh'
# alias deps='mate ~/.babushka/deps'
# 
# alias gist="open http://gist.github.com"
# 
# alias days="git log --since='2 month ago' --author=nkpart | grep Date | awk '{print \$2, \$3, \$4}' | uniq"
# 
# alias my_work="git log --since='2 month ago' --date=short --author=nkpart --pretty=format:\"%ad\" | uniq"
# 

alias src="cd ~/src"
alias "cd.."="cd .."

# function go () {
# 	PROJECT_DIRS="$HOME/Projects"
# 	RES=`find $PROJECT_DIRS -iname "${1}*" -maxdepth 1 | head -n 1`
# 	if [[ "$RES" == "" ]]; then
# 		cd "$PROJECT_DIRS"
# 	else
# 		cd "$RES"
# 	fi
# }

alias rehash="hash -r"

function desym
{
    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/Current/Resources/symbolicatecrash -A -v $1 . | more
}

alias symbolicate="/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/A/Resources/symbolicatecrash -v"

export DEVELOPER_DIR=`xcode-select --print-path`

export DEV_FOLDER=/Applications/Xcode.app/Contents/Developer

alias gopushtest="ssh deploy@oomph-integration.mogeneration.com"

function ox() {
  xcselect -o
}

function ku() {
  pushd ~/.kit && rm -Rf packages && git pull && popd
}

function fp() {
	PROJECT_DIR="$HOME/Projects"
	echo `find "$PROJECT_DIR" -iname "${1}*" -maxdepth 1 | head -n 1`
}

function go () {
  local PROJECT=`fp $1`

  if [ -d "$PROJECT" ]; then
    cd "$PROJECT"
  else
    echo "There is no project like:" $1
  fi
}

function gu() {
  if [ -n "$1" ]; then
    local PROJECT=`fp $1`
  else
    local PROJECT=`pwd`
  fi

  if [ -d "$PROJECT" ]; then
    cd "$PROJECT"
  fi

  kit update
#  git fetch origin && git rebase -p && kit update
}

function goku() {
  if [ -n "$1" ]; then
    local PROJECT=`fp $1`
  else
    local PROJECT=`pwd`
  fi

  echo "\nUpdating Kits"
 ku

  if [ -d "$PROJECT" ]; then
    if [ -d "$PROJECT/dev-packages" ]; then
      for package in `ls $PROJECT/dev-packages`; do
        echo "\nUpdating $package"
        gu "$package"
      done
    fi
  fi

  echo "\nUpdating `basename $PROJECT`"
  gu `basename $PROJECT`
}

alias bb='/usr/local/bin/bbedit'

alias om='EXISTING_DIR=`pwd`;cd ~/Projects/oompf-ipad;ox;cd "$EXISTING_DIR"'
alias ov='EXISTING_DIR=`pwd`;cd ~/Projects/oompf-ipad/oomph-ios-viewer;ox;cd "$EXISTING_DIR"'


alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

alias devkit='~/Projects/kit/dist/build/kit/kit'