{ inputs, outputs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {

    # useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      me = import ../home-manager/home.nix;
    };
  };
}
