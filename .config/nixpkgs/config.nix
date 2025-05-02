# https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
# symlink from ~/.config/nixpkgs/config.nix
{
  allowBroken = true;
  packageOverrides = pkgs: with pkgs; rec {
    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/sbin:/bin:/usr/sbin:/usr/bin
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:/usr/share/man
    '';
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (runCommand "profile" {} ''
          mkdir -p $out/etc/profile.d
          cp ${myProfile} $out/etc/profile.d/my-profile.sh
        '')
        atuin
        awscli2
        bat
        delta
        direnv
        entr
        fd
        fish
        fishPlugins.foreign-env
        fzf
        git
        jq
        neovim
        nix-direnv
        pre-commit
        (
          python3.withPackages (
          ps: with ps; [
            black
            ipython
            mccabe
            pylint
            python-lsp-server
            pynvim
          ]
        )
        )
        repgrep
        starship
        tldr
        tree
        tmux
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/etc" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
