{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # Replace with you arch
      system = "x86_64-linux";
      modules = [
        ./host/configuration.nix
        ./host/hardware-configuration.nix
        ./modules/host/desktop
        ./modules/config/options.nix

        home-manager.nixosModules.home-manager
        {
          # Replace username
          home-manager.users.oscar = import ./home/home.nix;
        }
      ];
    };
  };
}
