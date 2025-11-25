{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";

  # System Packages
  home.systemPackages = with pkgs; [
    nixd
    alejandra
    vscode
    obsidian
    stremio
    gnomeExtensions.paperwm
    gnomeExtensions.appindicator
  ];

  # Programs
  programs.git = {
    enable = true;
    userName = "oscar370";
    userEmail = "oscar.dga@outlook.com";
  };

  # GNOME Configuration
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "paperwm@paperwm.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
      ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefers-dark";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = "<Super>q";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = "<Shift><Super>s";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = "<Super>e";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "gnome-terminal";
      binding = "<Super>T";
    };
  };

  home.stateVersion = "25.05";
}
