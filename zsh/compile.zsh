#!/usr/bin/env zsh
# Compile zsh files to .zwc for faster loading
# Run this after modifying any .zsh files

echo "Compiling zsh files for faster loading..."

# Compile main zshrc
[[ -f ~/.zshrc ]] && zcompile ~/.zshrc

# Compile dotfiles zsh files
for file in ~/.dotfiles/zsh/**/*.zsh(N); do
    zcompile "$file"
done

# Compile theme
[[ -f ~/.dotfiles/zsh/themes/my-theme/my-theme.zsh-theme ]] && \
    zcompile ~/.dotfiles/zsh/themes/my-theme/my-theme.zsh-theme

# Compile plugins
[[ -f ~/.zsh_plugins.zsh ]] && zcompile ~/.zsh_plugins.zsh

echo "✓ Compilation complete! Your shell will now load faster."
echo "Run this script again whenever you modify .zsh files."
