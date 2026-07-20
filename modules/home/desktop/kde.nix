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
      "kcminputrc"."Mouse"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Mouse"."AccelerationProfile" = 1;

      kscreenlockerrc.Daemon.Autolock = false;
      kscreenlockerrc.Daemon.Timeout = 0;
      ksmserverrc.General.loginMode = "emptySession";

      kdeglobals.KDE.AnimationDurationFactor = 0.75;
    };
  };
}
