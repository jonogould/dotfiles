#custom
alias c="cd"
alias zshc="sublime ~/.dotfiles/zsh &"
alias cw="cd /home/jono/Sites"
alias st="sublime"

function take() {
  mkdir -p $1
  cd $1
}

function stake() {
  mkdir -p $1
  cd $1
  sublime . &
}

# ls
alias ls="ls -FG"
alias l="ls -lhG"
alias ll="ls -lhG"
alias la='ls -AG'

# Software updates
alias bu='brew update && brew upgrade'
alias nu='sudo npm update -g'
alias ku='update-my-projects'

update-my-projects() {
	# Loop through $PROJECTS directory
	# and update all git repo's
	for dir in $PROJECTS/*
	do
		if [ -d "$dir/.git" ]; then
			(cd $dir && git pull origin master)
		fi
	done
	cd $PROJECTS
}

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
SINCE="4am"

today() {
	git log --graph --since="${SINCE}" --pretty="tformat:${FORMAT}" $* |
	# Line columns up based on }delimiter
	column -s '}' -t |
	# Page only if we need to
	less -FXRS
	# Count commits
	COUNT=`git log --graph --since=$SINCE --oneline |
	wc -l |
	sed 's/^ *//g'`
	echo "  ${COUNT} commits since ${SINCE}"
}

# Job & Process Management
alias s='screen'
alias sr='screen -r'

# Vim inspired key mappings
alias :e='gvim'
alias :q='exit'

# Tree
alias tr='tree -d --prune -L 3'

# Hosts
alias :knnktr='ssh knnktr.com'
