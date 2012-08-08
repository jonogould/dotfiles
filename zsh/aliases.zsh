# ls
alias ls="ls -FG"
alias l="ls -lAhG"
alias ll="ls -lAhG"
alias la='ls -AG'

# Git Aliases
alias br='git checkout -b'
alias branch='git checkout -b'
alias ga='git add'
alias gpom='git push origin master'
alias gs='git status'
alias gd='git diff'
alias gdt='git difftool'
alias gca='git commit -am'

HASH="%C(yellow)%h%Creset"
ABSTIME="%Cgreen(%cd)%Creset"
AUTHOR="%C(bold blue)<%an>%Creset"
SUBJECT="%s"
FORMAT="$HASH}$ABSTIME}$AUTHOR} $SUBJECT"
SINCE="6am"

today() {
	git log --graph --since="${SINCE}" --pretty="tformat:${FORMAT}" $* |
	# Line columns up based on }delimiter
	column -s '}' -t |
	# Page only if we need to
	less -FXRS
	# Count commits
	COUNT=`git log --graph --since="6am" --oneline |
	wc -l |
	sed 's/^ *//g'`
	echo "  ${COUNT} commits since ${SINCE}"
}

# Job & Process Management
alias s='screen'
alias sr='screen -r'

# Vim inspired key mappings
alias :e='mvim'
alias :q='exit'

# Tree
alias tr='tree -d --prune -L 3'

# Hosts
alias :knnktr='ssh knnktr.com'
