# set PATH
set PATH /usr/local/bin             \
    $HOME/.local/bin                \
    $HOME/.cargo/bin                \
    $HOME/.node_modules_global/bin  \
    $PATH
set -x NODE_PATH ~/.node_modules_global/lib/node_modules

# set SHELL
set SHELL ~/.nix-profile/bin/fish

# https://stackoverflow.com/questions/60557160/python3-8-fails-with-fatal-python-error-config-get-locale-encoding
set -x LANG "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x LC_CTYPE "en_US.UTF-8"

set -x  RIPGREP_CONFIG_PATH $HOME/.ripgreprc

# imports
source ~/Prefs/.config/fish/aliases.fish
source ~/Prefs/.config/fish/functions/utilities.fish
source ~/Prefs/.config/fish/functions/cli_ide.fish

alias vi "nvim"

# vi-mode
function fish_vi_cursor; end
fish_vi_key_bindings

# pyenv support
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
which pyenv &> /dev/null
if test $status = 0
    pyenv init - | source
end

# Add fenv to path
set fish_function_path $fish_function_path ~/plugin-foreign-env/functions

# Source Nix setup script
fenv source ~/.nix-profile/etc/profile.d/nix.sh

# directory-based nix shells
direnv hook fish | source

# Starship prompt
starship init fish | source
