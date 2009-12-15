alias ls='ls -G'
alias ll='ls -lh'
alias lla='ls -lah'
alias ..='cd ..;'
alias ...='.. ..'
alias ducks='du -cks * | sort -rn|head -11' # Lists the size of all the folders$
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'

# useful command to find what you should be aliasing:
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

alias pp="cd '/Users/nkpart/Library/MobileDevice/Provisioning Profiles'"

alias r='rake'

alias mogen='ssh nick@mogeneration.com'

alias sql="echo Okay idjit, it goes like this:
echo CREATE TABLE tablename \(id INTEGER, name VARCHAR\)
echo SELECT row FROM tablename WHERE condition
echo INSERT INTO tablename \(column1, column2\) VALUES \(value1, value2\)
echo UPDATE tablename SET column1 = value1 WHERE condition
"

alias to_mp4="HandBrakeCLI -i %1 -o %1.mp4 --preset=\"iPhone & iPod Touch\""

alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gpa='git push-all' # see [alias] in ~/.gitconfig
alias gd='git diff | mate'
alias ga='git add'
alias gcl='git config --list'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gbc='git branch --color'
alias gba='git branch -a'
alias gco='git checkout'
alias gdc='git-svn dcommit'
alias gk='gitk --all &'
alias gpatch='git diff master -p'
alias gitrm="git stat | grep deleted | awk '{print $3}' | xargs git rm"
alias gitx="open -b nl.frim.GitX"
alias up='svn up' # trust me 3 chars makes a different
alias st='svn st' # local file changes
alias sstu='svn st -u' # remote repository changes
alias ci="svn commit -m ''" # commit
alias svn_branch_start='svn log --verbose --stop-on-copy .'
alias sra='svn revert -R *'
alias add_all="svn st | grep ? | awk '{ print  }' | xargs svn add"
alias ox="open *.xcodeproj"
alias ea='mate -w ~/p/dot-files/aliases.sh && source ~/p/dot-files/aliases.sh'
alias gist="open http://gist.github.com"

