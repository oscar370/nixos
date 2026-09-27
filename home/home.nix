{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  browser = "org.mozilla.firefox.desktop";
  textEditor = "org.gnome.TextEditor.desktop";

  textTypes = [
    "text/plain"
    "text/markdown"
    "text/x-log"
    "text/csv"
    "application/json"
    "application/xml"
    "text/xml"
    "application/toml"
    "application/x-yaml"
    "text/x-nix"
    "application/x-shellscript"
    "text/x-python"
    "text/css"
    "text/javascript"
    "application/javascript"
    "text/jsx"
    "application/x-typescript"
    "text/x-typescript"
    "text/tsx"
    "text/x-csrc"
    "text/x-chdr"
    "text/x-c++src"
    "text/x-csharp"
  ];
in
{
  # Imports
  imports = [
    ../modules/home/desktop/gnome.nix
  ];

  # Home Settings
  home = {
    username = username;
    homeDirectory = "/home/${username}";

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
    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = "${config.home.homeDirectory}/Escritorio";
      documents = "${config.home.homeDirectory}/Documentos";
      download = "${config.home.homeDirectory}/Descargas";
      music = "${config.home.homeDirectory}/Música";
      pictures = "${config.home.homeDirectory}/Imágenes";
      videos = "${config.home.homeDirectory}/Vídeos";
      templates = "${config.home.homeDirectory}/Plantillas";
      publicShare = "${config.home.homeDirectory}/Público";
      projects = null;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ browser ];
        "x-scheme-handler/http" = [ browser ];
        "x-scheme-handler/https" = [ browser ];
        "x-scheme-handler/about" = [ browser ];
        "x-scheme-handler/unknown" = [ browser ];
      }
      // lib.genAttrs textTypes (_: [ textEditor ]);

    };
  };

  home.stateVersion = "26.05";
}
