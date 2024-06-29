{
  inputs,
  lib,
  config,
  pkgs,
  flake-overlays,
  ...
}: {
  # You can import other NixOS modules here
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

  networking.hostName = "samsung-lt";

  ### Bluetooth fix
  services.udev.extraRules =
    ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="8086", ATTRS{idProduct}=="0189", ATTR{authorized}="0"
    '';

  system.stateVersion = "24.05";
}
