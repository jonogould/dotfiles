# startup
set -gx Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
set -U EDITOR code

# fish configs
source ~/.dotfiles/fish/alias.fish
source ~/.dotfiles/fish/functions/take.fish
source ~/.dotfiles/fish/functions/stake.fish

# gcloud sdk
if [ -f '/Users/jono/.tools/google-cloud-sdk/path.fish.inc' ]; . '/Users/jono/.tools/google-cloud-sdk/path.fish.inc'; end
