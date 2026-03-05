{
  config,
  pkgs,
  lib,
  ...
}: {
  # Imports
  imports = [
    /*
    ../modules/home/desktop/cosmic.nix
    */

    ../modules/home/desktop/gnome.nix
  ];

  # Replace
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";

  # Sometimes your user directories (Downloads, Documents, etc.) 
  # are not configured by default. 
  # If this is the case, remove the comments.
  #
  # xdg.userDirs = {
  #   enable = true;
  #   createDirectories = true;
  # };

  # User Packages
  home.packages = with pkgs; [
    nixd
    alejandra
    vscode
    spotify
    obsidian
  ];

  # Programs
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "oscar370";
        email = "oscar.dga@outlook.com";
      };
    };
  };

  # Bash Configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild --flake ~/.config/nixos switch";
      nixos-rebuild-update = "nix flake update --flake ~/.config/nixos && sudo nixos-rebuild --flake ~/.config/nixos switch";
      nixos-cleanup = "sudo nix-collect-garbage -d";
      nixos-list-generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    };
  };

  home.stateVersion = "25.05";
}
