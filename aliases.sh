alias ls='ls -G'
alias ll='ls -lah'
alias ..='cd ..;' # can then do .. .. .. to move up multiple directories.
alias ...='.. ..'
alias g='grep -i'  #case insensitive grep
alias ducks='du -cks * | sort -rn|head -11' # Lists the size of all the folders$
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
# useful command to find what you should be aliasing:
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# rails stuff
alias rlog='tail -f -0 ./log/*.log'
alias ss='ruby ./script/server'
alias sc='ruby ./script/console'
alias cdm='cap deploy deploy:migrate'

alias startpg='sudo /Library/StartupItems/PostgreSQL/PostgreSQL start'
alias h='history|g'
alias r='rake'

alias mogen='ssh nick@mogeneration.com'

alias sql="echo Okay idjit, it goes like this:
echo CREATE TABLE tablename \(id INTEGER, name VARCHAR\)
echo SELECT row FROM tablename WHERE condition
echo INSERT INTO tablename \(column1, column2\) VALUES \(value1, value2\)
echo UPDATE tablename SET column1 = value1 WHERE condition
"

alias to_mp4="HandBrakeCLI -i %1 -o %1.mp4 --preset=\"iPhone & iPod Touch\""

source ~/.aliases_git.sh
source ~/.aliases_svn.sh