{lib, ...}: {
  options.desktop = lib.mkOption {
    type = lib.types.enum ["gnome" "cosmic"];
    default = "gnome";
  };
}
