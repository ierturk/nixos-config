{ config, pkgs, ...}:
let
in {
  environment.systemPackages = with pkgs; [
    dolphin
    dunst
    kitty
    libnotify
    networkmanagerapplet
    rofi-wayland
    waybar
    pavucontrol
    wayvnc
    hyprpaper
    wofi
    blueman
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs; [
    font-awesome
    nerdfonts
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
