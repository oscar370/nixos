{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      noctalia,
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Replace with you arch

        modules = [
          nix-flatpak.nixosModules.nix-flatpak

          ./host/configuration.nix
          ./host/hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.oscar = ./home/home.nix; # replace with your actual username
              sharedModules = [
                noctalia.homeModules.default
              ];
            };
          }
        ];
      };
    };
}
