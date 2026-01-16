# Modern Dark Theme - Subdued colors for relaxed viewing
# Features: Git status, clean separators, easy on the eyes
# Standalone version - works without oh-my-zsh

# Muted colors optimized for dark backgrounds
local user_color="%F{73}"           # Soft teal
local dir_color="%F{111}"           # Muted blue-gray
local git_branch_color="%F{146}"    # Soft lavender-gray
local git_clean_color="%F{146}"     # Soft lavender-gray (subtle)
local git_dirty_color="%F{179}"     # Muted gold
local separator_color="%F{243}"     # Medium gray
local prompt_color="%F{253}"        # Soft white
local error_color="%F{174}"         # Muted rose
local time_color="%F{240}"          # Subtle gray
local reset="%f"

# Git status function (standalone, no oh-my-zsh required)
function git_prompt_info() {
    local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    
    local branch="${ref#refs/heads/}"
    local git_status=$(command git status --porcelain 2> /dev/null)
    local status_symbol=""
    
    if [[ -n $git_status ]]; then
        status_symbol=" ${git_dirty_color}✗${reset}"
    else
        status_symbol=" ${git_clean_color}✓${reset}"
    fi
    
    echo "${separator_color}on ${git_branch_color}${branch}${status_symbol}${reset} "
}

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

# Configure fast-syntax-highlighting with subdued colors
typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[default]='none'
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=174'                    # Muted rose for errors
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=146'                    # Soft lavender for keywords
FAST_HIGHLIGHT_STYLES[alias]='fg=111'                            # Muted blue-gray
FAST_HIGHLIGHT_STYLES[suffix-alias]='fg=111'
FAST_HIGHLIGHT_STYLES[builtin]='fg=111'                          # Muted blue-gray for builtins
FAST_HIGHLIGHT_STYLES[function]='fg=111'                         # Muted blue-gray for functions
FAST_HIGHLIGHT_STYLES[command]='fg=111'                          # Muted blue-gray for commands
FAST_HIGHLIGHT_STYLES[precommand]='fg=111'
FAST_HIGHLIGHT_STYLES[commandseparator]='fg=243'                 # Medium gray
FAST_HIGHLIGHT_STYLES[hashed-command]='fg=111'
FAST_HIGHLIGHT_STYLES[path]='fg=146'                             # Soft lavender for paths
FAST_HIGHLIGHT_STYLES[path_pathseparator]='fg=243'
FAST_HIGHLIGHT_STYLES[globbing]='fg=179'                         # Muted gold for globs
FAST_HIGHLIGHT_STYLES[history-expansion]='fg=146'
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=146'             # Soft lavender for options
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=146'
FAST_HIGHLIGHT_STYLES[back-quoted-argument]='fg=179'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=108'           # Soft sage for strings
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=108'           # Soft sage for strings
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=108'
FAST_HIGHLIGHT_STYLES[back-or-dollar-double-quoted-argument]='fg=179'
FAST_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=179'
FAST_HIGHLIGHT_STYLES[assign]='fg=146'
FAST_HIGHLIGHT_STYLES[redirection]='fg=243'
FAST_HIGHLIGHT_STYLES[comment]='fg=240'                          # Subtle gray for comments
FAST_HIGHLIGHT_STYLES[variable]='fg=179'                         # Muted gold for variables
FAST_HIGHLIGHT_STYLES[mathvar]='fg=179'
FAST_HIGHLIGHT_STYLES[mathnum]='fg=179'
FAST_HIGHLIGHT_STYLES[matherr]='fg=174'
FAST_HIGHLIGHT_STYLES[assign-array-bracket]='fg=243'
FAST_HIGHLIGHT_STYLES[for-loop-variable]='fg=179'
FAST_HIGHLIGHT_STYLES[for-loop-number]='fg=179'
FAST_HIGHLIGHT_STYLES[for-loop-operator]='fg=243'
FAST_HIGHLIGHT_STYLES[for-loop-separator]='fg=243'
FAST_HIGHLIGHT_STYLES[exec-descriptor]='fg=179'
FAST_HIGHLIGHT_STYLES[here-string-tri]='fg=243'
FAST_HIGHLIGHT_STYLES[here-string-text]='fg=108'
FAST_HIGHLIGHT_STYLES[here-string-var]='fg=179'
FAST_HIGHLIGHT_STYLES[secondary]='none'
FAST_HIGHLIGHT_STYLES[recursive-base]='none'