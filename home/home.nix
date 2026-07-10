{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Imports
  imports = [
    ../modules/home/desktop/gnome.nix
    # ../modules/home/desktop/cosmic.nix
    # ../modules/home/desktop/cinnamon.nix
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
    nil
    nixd
    nixfmt
    vscode
    firefox
    ungoogled-chromium
    obsidian
    mission-center
    stremio-linux-shell
    spotify
    rapidraw
    prismlauncher
    faugus-launcher
  ];

  # Programs
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "oscar370";
        email = "57201580+oscar370@users.noreply.github.com";
      };
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # Services
  services.syncthing = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
