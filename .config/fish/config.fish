# set PATH
set PATH $HOME/.nix-profile/bin                                       \
    /usr/local/bin                                                    \
    $HOME/.local/bin                                                  \
    $HOME/.cargo/bin                                                  \
    $HOME/.node_modules_global/bin                                    \
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" \
    $PATH
set -x NODE_PATH ~/.node_modules_global/lib/node_modules
set -xg TMPDIR /tmp

# set SHELL
set SHELL ~/.nix-profile/bin/fish

# https://stackoverflow.com/questions/60557160/python3-8-fails-with-fatal-python-error-config-get-locale-encoding
set -x LANG "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x LC_CTYPE "en_US.UTF-8"

set -x RIPGREP_CONFIG_PATH $HOME/.ripgreprc

# imports
source ~/Prefs/.config/fish/aliases.fish
source ~/Prefs/.config/fish/functions/utilities.fish
source ~/Prefs/.config/fish/functions/cli_ide.fish

alias vi nvim

# vi-mode
function fish_vi_cursor
end
fish_vi_key_bindings

# Add fenv to path
set fish_function_path $fish_function_path ~/plugin-foreign-env/functions

# Source Nix setup script
# see https://github.com/lilyball/nix-env.fish

# directory-based nix shells
direnv hook fish | source

# atuin magical shell history
set -gx ATUIN_NOBIND true
atuin init fish | source

# Starship prompt
starship init fish --print-full-init | source

# nix workaround
# see https://github.com/NixOS/nix/issues/7914
launchctl setenv NIX_SSL_CERT_FILE ~/octane/ZscalerRootCertificate-2048-SHA256.crt
