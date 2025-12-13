{
  config,
  pkgs,
  lib,
  ...
}: {
  # Imports
  imports = [
    ../modules/home/desktop/cosmic.nix
    /*
    ../modules/home/desktop/gnome.nix
    */
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

  # GNOME Configuration
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        paperwm.extensionUuid
        appindicator.extensionUuid
        user-themes.extensionUuid
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
