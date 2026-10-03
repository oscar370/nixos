{
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./gnome.nix
    ./xdg.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";

    packages = with pkgs; [
      nixd
      nixfmt
      devenv
      zed-editor
      xdg-ninja

      obsidian
      spotify
      rapidraw
      mission-center
    ];

    pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
      dotIcons.enable = false; # don't create ~/.icons
    };
  };

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/bash/history";
    };

    git = {
      enable = true;
      settings.user = {
        name = "oscar370";
        email = "57201580+oscar370@users.noreply.github.com";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };
}
