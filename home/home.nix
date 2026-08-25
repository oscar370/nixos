{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Imports
  imports = [
    ../modules/home/desktop/noctalia.nix
  ];

  # Replace
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";

  # User Packages
  home.packages = with pkgs; [
    nixd
    nixfmt
    devenv
    vscode
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

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;

    size = 16;

    gtk.enable = true;
    x11.enable = true;
  };

  # Services
  services.syncthing = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
