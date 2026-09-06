{
  config,
  pkgs,
  lib,
  username,
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

  # Home Settings
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    packages = with pkgs; [
      nixd
      nixfmt
      devenv
      mission-center
    ];

    pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  # Programs
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "oscar370";
          email = "57201580+oscar370@users.noreply.github.com";
        };
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };

  # Services
  services = {
    syncthing.enable = true;
  };

  # XDG / MIME Types
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ browser ];
        "x-scheme-handler/http" = [ browser ];
        "x-scheme-handler/https" = [ browser ];
        "x-scheme-handler/about" = [ browser ];
        "x-scheme-handler/unknown" = [ browser ];
      };
    };
  };
}
