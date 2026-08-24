{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.noctalia = {
      enable = true;
      settings = {
        # configure options
      };
    };
}
