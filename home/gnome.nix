{
  lib,
  pkgs,
  ...
}:
let
  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
in
{
  home.packages = with pkgs; [
    morewaita-icon-theme
    gnome-tweaks
  ];

  home.pointerCursor = cursor // {
    enable = true;
    dotIcons.enable = false;
  };

  # Installs and enables the extensions
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; }
      { package = paperwm; }
    ];
  };

  # Nautilus' wrapper only bundles basic GStreamer plugins; point every GNOME app
  # at the system ones so the audio/video properties can read MP4 (H.264/AAC)
  systemd.user.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0";
  };

  dconf.settings = {
    # Appearance
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
      icon-theme = "MoreWaita";
      cursor-theme = cursor.name;
      cursor-size = cursor.size;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    # Never sleep or dim
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      idle-dim = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };

    # Wait longer before the "not responding" dialog (shader compilation, ENB…)
    "org/gnome/mutter" = {
      check-alive-timeout = lib.hm.gvariant.mkUint32 30000;
    };

    # Keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>e" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "kgx";
      binding = "<Super>t";
    };

    # PaperWM
    "org/gnome/shell/extensions/paperwm" = {
      disable-topbar-styling = true;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      show-workspace-indicator = false;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      take-window = [ "" ];
    };
  };
}
