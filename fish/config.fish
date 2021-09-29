# startup
set -gx Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
set -U EDITOR code

# add paths
fish_add_path /usr/local/opt/node@14/bin
fish_add_path ~/.tools
fish_add_path ~/go/bin

# gcloud sdk
if [ -f '/Users/jono/.tools/google-cloud-sdk/path.fish.inc' ]; . '/Users/jono/.tools/google-cloud-sdk/path.fish.inc'; end

# fish configs
source ~/.dotfiles/fish/functions/take.fish
source ~/.dotfiles/fish/functions/stake.fish
source ~/.dotfiles/fish/functions/csp.fish

source ~/.dotfiles/fish/alias.fish
