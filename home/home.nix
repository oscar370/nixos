{
  config,
  pkgs,
  lib,
  ...
}: {
  # Replace
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";

  nixpkgs.config = {allowUnfree = true;};

  # System Packages
  home.packages = with pkgs; [
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
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = ["<Super>e"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "kgx";
      binding = "<Super>t";
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      take-window = ["<Super>w"];
    };

    "org/gnome/shell/extensions/paperwm" = {
      disable-topbar-styling = true;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      show-workspace-indicator = false;
    };
  };

  home.stateVersion = "25.05";
}
