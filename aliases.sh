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
