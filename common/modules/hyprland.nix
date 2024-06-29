{ config, pkgs, ...}:
let
in {
  environment.systemPackages = with pkgs; [
    yazi
    dunst
    kitty
    libnotify
    networkmanagerapplet
    hyprlang
    waybar
    pavucontrol
    wayvnc
    hyprpaper
    wofi
    blueman
    hyprlock
    hypridle
    wl-clipboard
    grim
    slurp

    ## wl tools
    wlrctl
    wlroots
    wlr-randr
    wlr-protocols
    wlr-layout-ui
    xdg-desktop-portal-wlr
    wvkbd
    wlsunset
    wl-color-picker
    hyprpicker
    tinywl
    mpvpaper
    nwg-bar
    ironbar
    wmenu
    wf-recorder
    kanshi
    wayout
    wl-screenrec
    wayshot
    nwg-look
    wlogout

    libva
    libva-utils
    libdrm
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    font-awesome
    (pkgs.nerdfonts.override {
      fonts = [
        "Meslo"
      ];
    })
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
  ];
}
