{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: {
        src = final.fetchFromGitHub {
          owner = "3akev";
          repo = "xwayland-satellite";
          rev = "9d51b59ff3c38464e7654096c9b10a8052a26b25";
          hash = final.lib.fakeHash;
        };
        cargoDeps = final.rustPlatform.fetchCargoVendor {
          src = final.fetchFromGitHub {
            owner = "3akev";
            repo = "xwayland-satellite";
            rev = "9d51b59ff3c38464e7654096c9b10a8052a26b25";
            hash = final.lib.fakeHash;
          };
          hash = final.lib.fakeHash;
        };
      });
    })
  ];
}
