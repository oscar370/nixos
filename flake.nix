{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-26.05";

    reel = {
      url = "github:oscar370/reel";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      reel,
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
          catppuccin.nixosModules.catppuccin

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit reel; };
              sharedModules = [
                catppuccin.homeModules.catppuccin
                ({ osConfig, ... }: {
                  catppuccin = { inherit (osConfig.catppuccin) enable flavor accent; };
                })
              ];
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
