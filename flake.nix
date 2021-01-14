{
  description = "hcards Flake";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    haskell-nix = {
      url = "github:input-output-hk/haskell.nix";
    };
  };

  outputs = { self, flake-utils, haskell-nix }:
    flake-utils.lib.eachSystem (builtins.attrNames haskell-nix.legacyPackages)
      (system:
        with haskell-nix.legacyPackages.${system};
        let
          project = pkgs.haskell-nix.cabalProject {
            compiler-nix-name = "ghc8102";
            index-state = "2021-01-01T00:00:00Z";
            src = pkgs.haskell-nix.haskellLib.cleanGit {
              name = "sources";
              src = ./.;
            };
          };
        in
        rec {
          defaultApp = {
            type = "app";
            program = "${defaultPackage}/bin/hcards-exe";
          };

          defaultPackage = project.hcards.components.exes.hcards-exe;

          devShell = project.shellFor {};
        }
      );
}
