{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "me";
    homeDirectory = "/home/me";
  };

  home.packages = with pkgs; [
    # wayland-utils
    # egl-wayland
    aha
    clinfo
    glxinfo
    vulkan-tools
    gpu-viewer
    gnupg
    gitFull
    pinentry-all

    ###### KDE 6
    # kdePackages.kate
    # kdePackages.kwallet-pam
    # kdePackages.bluedevil
    # kdePackages.plasma-browser-integration
    # kdePackages.flatpak-kcm
    # kdePackages.discover
    # kdePackages.krdp
    # kdePackages.krdc
    # kdePackages.sddm-kcm
    ######

    ###### KDE 5
    libsForQt5.kate
    libsForQt5.kwallet-pam
    libsForQt5.bluedevil
    libsForQt5.plasma-browser-integration
    libsForQt5.flatpak-kcm
    libsForQt5.discover
    # libsForQt5.sddm-kcm
    #######

    flatpak
    ### Install from Discover by using Flatpak ( FlatHub )
    # nomachine-client
    ### End of Discover

    vscode
    microsoft-edge
    teams-for-linux
    wireshark
    solaar
    spotify
    vlc
    remmina
  ];

  home.file = {

    ##### Global git config
    ".gitconfig".source = ../dotfiles/gitconfig;

    ##### Hyprland
    ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
    ### Wallpaper config
    ".config/hypr/hyprpaper.conf".source = ../dotfiles/config/hypr/hyprpaper.conf;
    ".config/hypr/wallpapers/OneStandsOut.jpg".source = ../dotfiles/config/hypr/wallpapers/OneStandsOut.jpg;
    ### WayBar config
    ".config/waybar/config".source = ../dotfiles/config/waybar/config;
    ".config/waybar/mocha.css".source = ../dotfiles/config/waybar/mocha.css;
    ".config/waybar/style.css".source = ../dotfiles/config/waybar/style.css;
    ### Wofi
    ".config/wofi/style.css".source = ../dotfiles/config/wofi/style.css;
    ### Hypridle
    ".config/hypr/hypridle.conf".source = ../dotfiles/config/hypr/hypridle.conf;

    ##### WayVnc
    ".config/wayvnc/config".source = ../dotfiles/config/wayvnc/config;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = '''';
  };

  programs.direnv.enable = true;
  # programs.git.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.05";
}
