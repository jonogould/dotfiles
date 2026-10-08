# custom
alias _="sudo"
alias c="cd"

# Work/employer-specific navigation aliases live in zsh/local.zsh (gitignored).

# dotfiles
alias c_dot="cursor ~/.dotfiles/"
alias reload="source ~/.zshrc && echo 'zshrc reloaded'"

# ls
# BSD/macOS ls colorizes with -G; GNU coreutils & BusyBox (e.g. Home Assistant)
# use --color=auto. Detect the supported flag once so these work everywhere.
if command ls --color=auto -d . >/dev/null 2>&1; then
    _ls_color='--color=auto'
else
    _ls_color='-G'
fi
alias l="ls -lh ${_ls_color}"
alias ls="ls -F ${_ls_color}"
alias la="ls -lA ${_ls_color}"
alias ll="clear && ls -lah ${_ls_color}"
unset _ls_color
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

# Vim inspired key mappings
alias :q='exit'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
