
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

# ignores empty directories
alias ignore_empty='find . \( -type d -empty \) -and \( -not -regex ./\.git.* \) -exec touch {}/.gitignore \;'
