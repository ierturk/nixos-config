{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/hyprland.nix
  ];

  home = {
    username = "me";
    homeDirectory = "/home/me";
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.05";
}
