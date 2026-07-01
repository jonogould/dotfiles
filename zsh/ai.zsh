# API keys AND the private endpoint are stored in .env (gitignored), sourced here.
[[ -f $DOTFILES/.env ]] && source $DOTFILES/.env

# Claude — ANTHROPIC_BASE_URL and GOCODE_API_TOKEN are provided by .env above.
export ANTHROPIC_AUTH_TOKEN=$GOCODE_API_TOKEN
# export ANTHROPIC_MODEL="claude-opus-4-8[1m]"
export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=1
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
export DISABLE_AUTOUPDATER=1
export CLAUDE_CODE_NO_FLICKER=1

alias claude='ANTHROPIC_BASE_URL=$ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN=$GOCODE_API_TOKEN claude  --dangerously-skip-permissions'

# Aider
alias aider='ANTHROPIC_BASE_URL=$ANTHROPIC_BASE_URL ANTHROPIC_API_KEY=$GOCODE_API_TOKEN aider --model $ANTHROPIC_MODEL'

# Codex
alias codex='OPENAI_BASE_URL=$ANTHROPIC_BASE_URL OPENAI_API_KEY=$GOCODE_API_TOKEN codex -m gpt-5-codex'
