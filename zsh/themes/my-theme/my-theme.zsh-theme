# Modern Dark Theme - Subdued colors for relaxed viewing
# Features: Git status, clean separators, easy on the eyes
# Standalone version - works without oh-my-zsh

# Muted colors optimized for dark backgrounds
local user_color="%F{73}"           # Soft teal
local dir_color="%F{111}"           # Muted blue-gray
local git_color="%F{146}"           # Soft lavender-gray
local git_dirty_color="%F{179}"     # Muted gold
local separator_color="%F{243}"     # Medium gray
local prompt_color="%F{253}"        # Soft white
local error_color="%F{174}"         # Muted rose
local time_color="%F{240}"          # Subtle gray
local reset="%f"

# Git prompt caching for ultra-fast rendering
typeset -g _git_prompt_cache=""
typeset -g _git_prompt_pwd=""

# Git status function with aggressive caching for performance
function git_prompt_info() {
    # Cache based on current directory
    if [[ "$PWD" != "$_git_prompt_pwd" ]]; then
        _git_prompt_pwd="$PWD"
        _git_prompt_cache=""
    fi
    
    # Return cached result if available
    [[ -n "$_git_prompt_cache" ]] && { echo "$_git_prompt_cache"; return }
    
    # Quick git check - only get branch name
    local ref
    ref=$(command git symbolic-ref --short HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    
    # Fast dirty check - skip untracked files for speed
    local status_symbol=""
    if command git diff --quiet --ignore-submodules HEAD 2> /dev/null; then
        if command git diff-index --cached --quiet --ignore-submodules HEAD -- 2> /dev/null; then
            status_symbol=" ${git_color}✓${reset}"
        else
            status_symbol=" ${git_dirty_color}✗${reset}"
        fi
    else
        status_symbol=" ${git_dirty_color}✗${reset}"
    fi
    
    # Cache and return
    _git_prompt_cache="${separator_color}on ${git_color}${ref}${status_symbol}${reset} "
    echo "$_git_prompt_cache"
}

# Clear git cache on directory change
autoload -Uz add-zsh-hook
function _clear_git_cache() {
    _git_prompt_cache=""
}
add-zsh-hook chpwd _clear_git_cache

# Show username when SSH or root
local user_prompt=""
if [[ -n "$SSH_CONNECTION" ]] || [[ $EUID -eq 0 ]]; then
    user_prompt="${user_color}%n${reset} ${separator_color}at${reset} "
fi

# Enable prompt substitution
setopt PROMPT_SUBST

# Main prompt - single line with better visual hierarchy
PROMPT='${user_prompt}${dir_color}%~${reset} $(git_prompt_info)${prompt_color}❯${reset} '

# Right prompt with exit status and time
RPROMPT='%(?..${error_color}✘ %?${reset} )${time_color}%*${reset}'

# Configure fast-syntax-highlighting with subdued colors (optimized for performance)
typeset -gA FAST_HIGHLIGHT_STYLES
# Core elements (most commonly used)
FAST_HIGHLIGHT_STYLES[default]='none'
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=174'
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=146'
FAST_HIGHLIGHT_STYLES[alias]='fg=111'
FAST_HIGHLIGHT_STYLES[builtin]='fg=111'
FAST_HIGHLIGHT_STYLES[function]='fg=111'
FAST_HIGHLIGHT_STYLES[command]='fg=111'
FAST_HIGHLIGHT_STYLES[path]='fg=146'
FAST_HIGHLIGHT_STYLES[globbing]='fg=179'
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=146'
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=146'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=108'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=108'
FAST_HIGHLIGHT_STYLES[comment]='fg=240'
FAST_HIGHLIGHT_STYLES[variable]='fg=179'
FAST_HIGHLIGHT_STYLES[commandseparator]='fg=243'
FAST_HIGHLIGHT_STYLES[redirection]='fg=243'