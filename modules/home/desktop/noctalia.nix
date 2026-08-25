{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    pkgs.polkit_gnome
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      osd = {
        enable_key_osd = false;
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

  xdg.configFile."niri/config.kdl".source =
    pkgs.runCommand "niri-config-checked"
      {
        nativeBuildInputs = [ pkgs.niri ];
      }
      ''
        niri validate --config ${../../utils/niri/config.kdl}
        cp ${../../utils/niri/config.kdl} $out
      '';
}
