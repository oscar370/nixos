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

  nixpkgs.config = {allowUnfree = true;};

  # User Packages
  home.packages = with pkgs; [
    nixd
    alejandra
    vscode
    gnomeExtensions.paperwm
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
  ];

  # Programs
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "oscar370";
        email = "oscar.dga@outlook.com";
      };

      core.sshCommand = "false";
    };
  };

  # Bash Configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      nr = "sudo nixos-rebuild --flake ~/.config/nixos switch";
      nrbuild = "sudo nixos-rebuild --flake ~/.config/nixos build";
      nrboot = "sudo nixos-rebuild --flake ~/.config/nixos boot";
      nrfu = "nix flake update --flake ~/.config/nixos && sudo nixos-rebuild --flake ~/.config/nixos switch";
      nrclean = "sudo nix-collect-garbage -d";
      nrgens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    };
  };

  # GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Remove GNOME apps
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-contacts
    gnome-clocks
    gnome-weather
    gnome-maps
    snapshot
    simple-scan
    gnome-characters
    gnome-connections
    gnome-font-viewer
    decibels
    baobab
    gnome-system-monitor
    geary
    gnome-calendar
    gnome-music
    epiphany
    seahorse
  ];

  home.stateVersion = "25.05";
}
