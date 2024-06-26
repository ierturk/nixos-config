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

  networking.hostName = "samsung-lt";

  ### Bluetooth fix
  services.udev.extraRules =
    ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="8086", ATTRS{idProduct}=="0189", ATTR{authorized}="0"
    '';

  system.stateVersion = "24.05";
}
