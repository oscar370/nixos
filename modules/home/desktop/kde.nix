{
  config,
  pkgs,
  lib,
  ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze-dark";
  };

  programs.plasma = {
    enable = true;

    workspace.colorScheme = "BreezeDark";

    shortcuts = {
      "Kwin"."Window Close" = "Meta+Q";

      "org.kde.spectacle.desktop"."RectangularRegionScreenShot" = "Meta+Shift+S";

      "org.kde.dolphin.desktop"."_launch" = "Meta+E";

      "org.kde.konsole.desktop"."_launch" = "Meta+T";
    };

    configFile = {
      "kcminputrc"."Mouse"."AccelerationProfile" = 1;

      "powermanagementprofilesrc"."AC"."SuspendThenHibernate"."Type" = 0;
      "powermanagementprofilesrc"."AC"."Suspend"."Type" = 0;
    };
  };
}
