{
  description = "Uzbek Localization Website";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Flake-parts utility
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      flake = {
        nixosModules.server = import ./module.nix self;
      };
      perSystem = {pkgs, ...}: {
        # Nix formatter
        formatter = pkgs.nixfmt-tree;

        # Exported output
        packages.default = pkgs.callPackage ./. {};

        # Development environment
        devShells.default = import ./shell.nix self {inherit pkgs;};
      };
    };
}
