{ pkgs, ... }:
{
  home.packages = with pkgs; [
    adwaita-icon-theme
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
