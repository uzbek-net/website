flake: {pkgs, ...}: let
  # Hostplatform system
  system = pkgs.hostPlatform.system;

  # Production package
  base = flake.packages.${system}.default;
in
  pkgs.mkShell {
    inputsFrom = [base];

    packages = with pkgs; [
      nodePackages.typescript-language-server

      nixd
      statix
      deadnix
      alejandra

      tailwindcss
    ];

    env = {
      NEXT_PUBLIC_SITE_URL = "https://uzbek.net.uz";
    };
  }
