# Prefix-filtered history search (Fish-style): type "ssh ", press ↑/↓ to cycle matches.
# Requires zsh-users/zsh-history-substring-search (loaded via ~/.zsh_plugins.zsh).

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_PREFIXED=1

_history_substring_search_bindkeys() {
  local keymap key
  local -a keys_up keys_down

  [[ -n ${terminfo[kcuu1]-} ]] && keys_up+=("${terminfo[kcuu1]}")
  [[ -n ${terminfo[kcud1]-} ]] && keys_down+=("${terminfo[kcud1]}")
  keys_up+=('^[[A' '^[OA')
  keys_down+=('^[[B' '^[OB')

  for keymap in viins vicmd emacs; do
    for key in "${keys_up[@]}"; do
      bindkey -M "$keymap" "$key" history-substring-search-up 2>/dev/null
    done
    for key in "${keys_down[@]}"; do
      bindkey -M "$keymap" "$key" history-substring-search-down 2>/dev/null
    done
  done
}

if whence -w history-substring-search-up &>/dev/null; then
  _history_substring_search_bindkeys
fi
