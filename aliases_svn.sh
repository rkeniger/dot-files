alias up='svn up' # trust me 3 chars makes a different
alias st='svn st' # local file changes
alias sstu='svn st -u' # remote repository changes
alias ci="svn commit -m ''" # commit
alias svn_branch_start='svn log --verbose --stop-on-copy .'
alias sra='svn revert -R *'
alias add_all="svn st | grep ? | awk '{ print  }' | xargs svn add"

