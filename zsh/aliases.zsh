# ls
alias ls="ls -FG"
alias l="ls -lAhG"
alias ll="ls -lG"
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

today() {
	git log --graph --since="6am" --pretty="tformat:${FORMAT}" $* |
	# Replace (2 years ago) with (2 years)
	sed -Ee 's/(^[^<]*) ago)/\1)/' |
	# Replace (2 years, 5 months) with (2 years)
	sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?)/\1)/' |
	# Line columns up based on }delimiter
	column -s '}' -t |
	# Page only if we need to
	less -FXRS
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
