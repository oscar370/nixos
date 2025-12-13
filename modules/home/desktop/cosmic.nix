{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.desktop == "cosmic") {
}
