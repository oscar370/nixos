{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    reel = {
      url = "github:oscar370/reel";
      flake = false;
    };

    paperwm-src = {
      url = "github:paperwm/PaperWM";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      reel,
      paperwm-src,
      ...
    }:
    let
      username = "oscar";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit username; };

        modules = [
          ./host/configuration.nix
          ./host/gnome.nix # Desktop (system)

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit reel paperwm-src; };
              users.${username}.imports = [
                ./home/home.nix
                ./home/gnome.nix # Desktop (user)
              ];
            };
          }
        ];
      };
    };
}
