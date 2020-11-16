# set PATH
set PATH /usr/local/bin $HOME/.local/bin $HOME/.cargo/bin $HOME/.node_modules_global/bin $PATH
set -x NODE_PATH ~/.node_modules_global/lib/node_modules

# https://stackoverflow.com/questions/60557160/python3-8-fails-with-fatal-python-error-config-get-locale-encoding
set -x LANG "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x LC_CTYPE "en_US.UTF-8"

# imports
source ~/Prefs/.config/fish/aliases.fish
source ~/Prefs/.config/fish/functions/utilities.fish

alias vi "nvim"

# vi-mode
function fish_vi_cursor; end
fish_vi_key_bindings

# pyenv support
pyenv init - | source
