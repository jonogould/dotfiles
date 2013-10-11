#custom
alias c="cd"
alias cw="cd /Users/admin/Sites"
alias tg="cd /var/www/dev.travelground"
alias _="sudo"
alias composer="php ~/.tools/composer.phar"

#configs
alias c_dot="subl ~/.dotfiles"
alias c_nginx="subl /usr/local/etc/nginx/nginx.conf"
alias c_php="subl /usr/local/etc/php/5.5/php.ini"

function take() {
  mkdir -p $1
  cd $1
}

function stake() {
  mkdir -p $1
  cd $1
  stt
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
alias gss='git status -s'
alias gd='git diff'
alias gdt='git difftool'
alias gca='git commit -am'
alias gco='git checkout'
alias gcm='git checkout master'
alias gba='git branch -a'


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
