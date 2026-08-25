{ pkgs, ... }:
{
  programs.noctalia = {
    enable = true;
    settings = {
      osd = {
        enable_key_osd = false;
      };
    };
  };

  xdg.configFile."niri/config.kdl".source =
    pkgs.runCommand "niri-config-checked"
      {
        nativeBuildInputs = [ pkgs.niri ];
      }
      ''
        niri validate --config ${./config.kdl}
        cp ${./config.kdl} $out
      '';

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.coreutils}/bin/env noctalia";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
