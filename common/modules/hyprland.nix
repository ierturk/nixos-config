{ config, pkgs, ...}:
let
in {
  home.packages = with pkgs; [
    aha
    clinfo
    glxinfo
    vulkan-tools
    gpu-viewer
    gnupg
    gitFull
    pinentry-all
    vscode
    microsoft-edge
    teams-for-linux
    wireshark
    solaar
    spotify
    vlc
    remmina

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

  home.file = {

    ##### Global git config
    ".gitconfig".source = ../dotfiles/gitconfig;

    ##### Hyprland
    # ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
    # getting from the option by extraConfig
    ### Wallpaper config
    ".config/hypr/hyprpaper.conf".source = ../dotfiles/config/hypr/hyprpaper.conf;
    ".config/hypr/images/OneStandsOut.jpg".source = ../dotfiles/config/hypr/images/OneStandsOut.jpg;
    ### WayBar config
    ".config/waybar/config".source = ../dotfiles/config/waybar/config;
    ".config/waybar/style.css".source = ../dotfiles/config/waybar/style.css;
    ".config/waybar/mediaplayer.py".source = ../dotfiles/config/waybar/mediaplayer.py;
    ### Wofi
    ".config/wofi/style.css".source = ../dotfiles/config/wofi/style.css;
    ### Hypridle
    ".config/hypr/hypridle.conf".source = ../dotfiles/config/hypr/hypridle.conf;
    ### Hyprlock
    ".config/hypr/hyprlock.conf".source = ../dotfiles/config/hypr/hyprlock.conf;
    ".config/hypr/mocha.conf".source = ../dotfiles/config/hypr/mocha.conf;
    ".config/hypr/images/avatar.jpeg".source = ../dotfiles/config/hypr/images/avatar.jpeg;

    ### wlogout config
    ".config/wlogout/layout".source = ../dotfiles/config/wlogout/layout;
    ".config/wlogout/style.css".source = ../dotfiles/config/wlogout/style.css;

    ##### WayVnc
    ".config/wayvnc/config".source = ../dotfiles/config/wayvnc/config;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = '''';
  };

  programs.direnv.enable = true;

  programs.kitty = {
    enable = true;
    extraConfig = "";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprexpo
    ];
    extraConfig = ''
      ${builtins.readFile ../dotfiles/config/hypr/hyprland.conf}
      ${builtins.readFile ../dotfiles/config/hypr/hyprexpo.conf}
    '';
    settings = {
      exec-once = [
        ''${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &''
      ];
    };
  };
}
