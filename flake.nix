{
  description = "Nixos Config Laptop and Server";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # MatLab FHS
    nix-matlab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-matlab,
    ...
  } @ inputs: let
    inherit (self) outputs;
    flake-overlays = [
      nix-matlab.overlay
    ];
  in
  {
    nixosConfigurations = {
      samsung-lt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs flake-overlays; };
        modules = [
          ./samsung/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.me = import ./common/home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs outputs flake-overlays; };
          }
        ];
      };

      home-lab = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs flake-overlays; };
        modules = [
          ./samsung/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.me = import ./common/home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs outputs flake-overlays; };
          }
        ];
      };

    };
  };
}
