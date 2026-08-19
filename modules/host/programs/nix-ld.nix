{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Automatically creates a loader in /lib/* to avoid patching stuff
  # To disable it temporarily use
  # unset NIX_LD
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

    ];
  };

}
