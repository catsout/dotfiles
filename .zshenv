# will be loaded to systemd user environment

export ZDOTDIR=$HOME/.config/zsh

. "$HOME/.config/set_env"

. "$HOME/.local/share/cargo/env"

if [ -e /var/home/out/.nix-profile/etc/profile.d/nix.sh ]; then . /var/home/out/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
