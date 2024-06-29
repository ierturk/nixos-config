{
  inputs,
  lib,
  config,
  pkgs,
  flake-overlays,
  ...
}: {

  imports = [
    ../../common/nixos/configuration.nix
    ../modules/filesystem.nix
    ../modules/hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      (
        final: prev: {
        }
      )
    ] ++ flake-overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "home-lab";

  system.stateVersion = "24.05";
}
