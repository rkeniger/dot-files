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
alias sleeep="osascript -e 'tell application \"System Events\" to sleep'"
alias kf="killall Finder"
alias svnig="svn propedit svn:ignore"
alias ka="killall"
alias glat="git --no-pager log -n3"

function lookfor() {
  grep -EiIrl "$*" ./* | grep -v '.svn'
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


alias sql="echo Okay idjit, it goes like this:
echo CREATE TABLE tablename \(id INTEGER, name VARCHAR\)
echo SELECT row FROM tablename WHERE condition
echo INSERT INTO tablename \(column1, column2\) VALUES \(value1, value2\)
echo UPDATE tablename SET column1 = value1 WHERE condition
"

alias foo="echo \$2 \$1"

function to_ipod() {
   VAL="HandBrakeCLI -i ${1} -o ${1}.mp4 --preset=\"iPhone & iPod Touch\""
   echo $VAL
   sh -c $VAL
}


alias gl='git pull'

alias gst='git status -sb'
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
# alias gfo='git fetch origin'
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
  TEST1=`find $PROJECT_DIRS -maxdepth 1 | grep \/$1 | head -n 1`
  TEST2=`find $PROJECT_DIRS -maxdepth 1 | grep \/[^\/]*$1[^\/]* | head -n 1`
  if [ ! -n $TEST1 ]
  then
    cd $TEST1
  else
    cd $TEST2
  fi
}
# 
# alias make_six='sed -i "" "s,<integer>5</integer>,<integer>6</integer>," Resources/Info.plist'
# alias make_six_qa='sed -i "" "s,<integer>5</integer>,<integer>6</integer>," Resources/Info-QA.plist'
# 
