{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ../../common/nixos/configuration.nix
    ../modules/filesystem.nix
    ../modules/hardware-configuration.nix
  ];

  networking.hostName = "home-lab";

  system.stateVersion = "24.05";
}
