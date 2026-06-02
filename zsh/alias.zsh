# custom
alias _="sudo"
alias c="cd"

# Work/employer-specific navigation aliases live in zsh/local.zsh (gitignored).

# dotfiles
alias c_dot="cursor ~/.dotfiles/"
alias reload="source ~/.zshrc && echo 'zshrc reloaded'"

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
alias gp='git pull'
alias gca='git commit -am'
alias gco='git checkout'
alias gcm='git checkout main'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gps='git push'

alias gst='git stash'
alias gust='git stash pop'

# Python
alias python='python3'
alias py='python3'

# Job & Process Management
alias s='screen'
alias sr='screen -r'

# Vim inspired key mappings
alias :e='gvim'
alias :q='exit'

# Tree
alias tr='tree -d --prune -L 3'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

alias dcu='docker compose up'
