{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    pkgs.polkit_gnome
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      bar.default = {
        margin_ends = 0;
        radius_top_left = 0;
        radius_top_right = 0;
      };

      dock = {
        enabled = true;
        reserve_space = false;
        smart_auto_hide = true;
      };

      osd.kinds = {
        keyboard_backlight = false;
        keyboard_layout = false;
        lock_keys = false;
        media = false;
        privacy = false;
      };

      theme = {
        builtin = "Kanagawa";
        community_palette = "Oxocarbon";
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-content";
        templates = {
          builtin_ids = [
            "gtk3"
            "gtk4"
            "niri"
            "qt"
          ];
        };
      };
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      WantedBy = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  xdg.configFile."niri/config.kdl".source = ../../utils/niri/config.kdl;
}
