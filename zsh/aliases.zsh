#custom
alias c="cd"
alias cw="cd /Users/admin/Sites"
alias _="sudo"

#configs
alias c_dot="subl ~/.dotfiles"
alias c_nginx="subl /usr/local/etc/nginx/nginx.conf"
alias c_php="subl /usr/local/etc/php/5.5/php.ini"

#php
alias composer="php ~/.tools/composer.phar"
alias phpunit="php ~/.tools/phpunit.phar"

#travelground
alias test_supp="phpunit --bootstrap tests/bootstrap/autoload.php"
alias stage="curl --user tg:tg 'stage.travelground.com/call_stage.php?code=u89ami7g3z2a&s'"

alias tg="cd /var/www/dev.travelground"

function gimme() {
  ~/Code/TG/vm/gimme/gimme.sh $1
  tail -f tsync-j_${$1//+([^-!/])/_}.log
}

# ls
alias l="ls -lhG"
alias ls="ls -FG"
alias la='ls -AG'
alias ll="clear && ls -lhG"
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'

# Git
alias gb='git checkout -b'
alias ga='git add --all'
alias gs='git status -s'
alias gc="git commit -m"
alias gp='git push'
alias gca='git commit -am'
alias gco='git checkout'
alias gcm='git checkout master'
alias gba='git branch -a'
alias gpl='git pull'

alias gst='git stash'
alias gust='git stash pop'

# Python
alias py='python3'

# Vagrant
alias vu='vagrant up'
alias vh='vagrant halt'
alias vs='vagrant status'
alias vssh='vagrant ssh'

# Software updates
alias bu='brew update && brew upgrade'
alias nu='sudo npm update -g'

# Job & Process Management
alias s='screen'
alias sr='screen -r'

# Vim inspired key mappings
alias :e='gvim'
alias :q='exit'

# Tree
alias tr='tree -d --prune -L 3'
