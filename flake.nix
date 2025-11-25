{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
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
        ./nix/configuration.nix

        home-manager.nixosModules.home-manager
        {
          # Replace username
          home-manager.users.oscar = import ./home/home.nix;
        }
      ];
    };
  };
}
