# set PATH
set PATH $HOME/miniconda3/bin /usr/local/bin $HOME/.local/bin /Library/Frameworks/Python.framework/Versions/3.6/bin $HOME/.cargo/bin $HOME/.node_modules_global/bin $PATH

# imports
source ~/Prefs/.config/fish/aliases.fish
source ~/Prefs/.config/fish/functions/utilities.fish

alias vi "nvim"

# vi-mode
function fish_vi_cursor; end
fish_vi_key_bindings
