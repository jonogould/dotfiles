# alias claude="~/.claude/local/claude"

# # GO CODE
# export ANTHROPIC_BASE_URL=https://REDACTED.example
# export ANTHROPIC_AUTH_TOKEN=$GOCODE_API_TOKEN

# export ANTHROPIC_BASE_URL=https://REDACTED.example
# export OPENAI_BASE_URL=https://REDACTED.example

# export ANTHROPIC_AUTH_KEY=$GOCODE_API_TOKEN 
# export OPENAI_API_KEY=$GOCODE_API_TOKEN

# # Claude
# export AWS_PROFILE="default"
# export CLAUDE_CODE_USE_BEDROCK="1"
# export AWS_REGION="us-west-2"

# export ANTHROPIC_MODEL="claude-sonnet-4-5-20250929"
# export ANTHROPIC_SMALL_FAST_MODEL="export ANTHROPIC_MODEL=claude-sonnet-4-5-20250929"

# # GO CODE

# # Aider
# alias aider="aider --model claude-sonnet-4-5-20250929"

# # Claude Code
# alias claude-code="ANTHROPIC_MODEL=claude-sonnet-4-5-20250929 claude-code"

# # Codex
# alias codex="codex -m gpt-5-codex"


# # Latest claude, using the 4.0 sonnet model and 3.5 haiku
# alias claude4="AWS_REGION=us-west-2 CLAUDE_CODE_USE_BEDROCK=1 ANTHROPIC_MODEL='us.anthropic.claude-sonnet-4-20250514-v1:0' ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0' npx @anthropic-ai/claude-code@latest --mcp-config ~/.claude/.mcp.json"

# # Latest claude, using the 4.0 opus model and 3.5 haiku
# alias claude4-opus="AWS_REGION=us-west-2 CLAUDE_CODE_USE_BEDROCK=1 ANTHROPIC_MODEL='us.anthropic.claude-opus-4-20250514-v1:0' ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0' npx @anthropic-ai/claude-code@latest --mcp-config ~/.claude/.mcp.json"

# # Added by LM Studio CLI (lms)
# export PATH="$PATH:/Users/jgould/.lmstudio/bin"
# # End of LM Studio CLI section

# #codex -m gpt-4o
# alias claude="/Users/jgould/.claude/local/claude"

export GOCODE_API_TOKEN=***REMOVED***

# Claude
alias claude="ANTHROPIC_BASE_URL=https://REDACTED.example ANTHROPIC_AUTH_TOKEN=$GOCODE_API_TOKEN ANTHROPIC_MODEL=claude-sonnet-4-5-20250929 claude"

# Aider
alias aider="ANTHROPIC_BASE_URL=https://REDACTED.example ANTHROPIC_API_KEY=$GOCODE_API_TOKEN aider --model claude-sonnet-4-5-20250929"

# Codex
alias codex="OPENAI_BASE_URL=https://REDACTED.example OPENAI_API_KEY=$GOCODE_API_TOKEN codex -m gpt-5-codex"