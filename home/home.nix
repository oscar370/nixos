{
  config,
  pkgs,
  lib,
  ...
}:
let
  browser = "org.mozilla.firefox.desktop";
in
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
    mission-center
  ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;

    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
      "x-scheme-handler/about" = [ browser ];
      "x-scheme-handler/unknown" = [ browser ];
    };
  };

  home.stateVersion = "25.11";
}
