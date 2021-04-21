#custom
alias c="cd"
alias cw="cd ~/Code/Over"
alias cc="cd ~/Code"
alias _="sudo"

#over
alias oc="cd ~/Code/Over/over-core-api; GOOGLE_APPLICATION_CREDENTIALS=/Users/jono/.config/gcloud/application_default_credentials.json DB_MIGRATION_AUTO=true ./gradlew bootRun"
alias og="cd ~/Code/Over/over-api-gateway; ./gradlew bootRun"

alias gc-dev="gcloud container clusters get-credentials over-api-dev-2 --zone us-east1-d --project over-services-dev"
alias gc-staging="gcloud container clusters get-credentials over-api-staging-3 --zone us-east1-d --project over-services"
alias gc-prod="gcloud container clusters get-credentials over-core-circle --zone us-east1-d --project over-services-prod"

alias csp-dev="csp over-services-dev:us-east1:over-core-dev 3309"
alias csp-staging="csp over-services:us-east1:over-core-staging-2 3310"
alias csp-prod="csp over-services-prod:us-east1:over-core-2 3311"
alias csp-prod-aux="csp over-services-prod:us-east1:over-services-aux 3312"

#configs
alias c_dot="subl ~/.dotfiles"
alias c_nginx="subl /usr/local/etc/nginx/nginx.conf"
alias c_php="subl /usr/local/etc/php/5.5/php.ini"

#php
alias composer="php ~/.tools/composer.phar"
alias phpunit="php ~/.tools/phpunit.phar"

#homestead
alias artisan="php artisan"
alias hsd="cd ~/Homestead"

# ls
alias l="ls -lhG"
alias ls="ls -FG"
alias la='ls -lAG'
alias ll="clear && ls -lahG"
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

alias mk='minikube'

# Python
alias py='python3'

# Vagrant
alias vu='vagrant up'
alias vh='vagrant halt'
alias vs='vagrant status'
alias vd='vagrant destroy'
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
