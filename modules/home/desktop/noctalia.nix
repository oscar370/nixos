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
        niri validate --config ${../../utils/config.kdl}
        cp ${../../utils/config.kdl} $out
      '';
}
