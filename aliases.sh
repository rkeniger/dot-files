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
alias editprofile="mate -w  ~/.profile && source ~/.profile";
alias kf="killall Finder"
alias svnig="svn propedit svn:ignore"
alias ka="killall"
alias kax="ka Xcode"
alias glat="git --no-pager log -n3"
alias ku="rm -rdf build Kits; kit update"
alias dfh="df -h"
alias xcb="xcodebuild"
alias xcb-debug="time xcodebuild -configuration Debug"


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

function h() {
  hoogle --color --count=30 ${1} 
}

# useful command to find what you should be aliasing:
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias pp="cd ~/Library/MobileDevice/Provisioning\ Profiles"

alias r='rake'

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

alias gl='git pull'

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
# 
# alias gitx="open -b nl.frim.GitX"
# alias gm='git merge --no-ff'
alias gfo='git fetch origin'
# alias grb='git rebase'
# alias gdi='git diff --staged'
# alias gd='git diff'
# 
# alias m=mvim
# 
alias ox="open *.xcodeproj || open iPhone/*.xcodeproj || open iPadPrototype/*.xcodeproj"
# alias ea='mvim -f ~/p/dot-files/aliases.sh && source ~/p/dot-files/aliases.sh'
# alias deps='mate ~/.babushka/deps'
# 
# alias gist="open http://gist.github.com"
# 
# alias days="git log --since='2 month ago' --author=nkpart | grep Date | awk '{print \$2, \$3, \$4}' | uniq"
# 
# alias my_work="git log --since='2 month ago' --date=short --author=nkpart --pretty=format:\"%ad\" | uniq"
# 
function go () {
	PROJECT_DIRS="$HOME/Projects"
	RES=`find $PROJECT_DIRS -iname "${1}*" -maxdepth 1 | head -n 1`
	if [[ "$RES" == "" ]]; then
		cd "$PROJECT_DIRS"
	else
		cd "$RES"
	fi
}

# alias make_six='sed -i "" "s,<integer>5</integer>,<integer>6</integer>," Resources/Info.plist'
# alias make_six_qa='sed -i "" "s,<integer>5</integer>,<integer>6</integer>," Resources/Info-QA.plist'
# 
