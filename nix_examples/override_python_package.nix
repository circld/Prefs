{ pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz) {} }:
let
  # skip failing post-build unit tests
  # adapted from https://jamesckent.com/2017/06/nix-over-riding-python-derivation-tests/
  python310Packages = pkgs.python310Packages.override (
    oldAttrs: {
      overrides = self: super: {
        dnspython = super.dnspython.overrideAttrs ( z: rec { doCheck=false; doInstallCheck = false; } );
        anyio = super.anyio.overrideAttrs ( z: rec { doCheck=false; doInstallCheck = false; } );
      };
    }
  );
  customPython3 = with python310Packages; pkgs.python310.buildEnv.override {
    extraLibs = [
      black
      certifi
      mccabe
      pandas
      pylint
      pynvim
      pytest
      python-lsp-server
    ];
  };
in

pkgs.mkShell {
  buildInputs = [
    customPython3
    pkgs.pre-commit
  ];
}
