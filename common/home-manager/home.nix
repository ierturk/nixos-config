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
    aha
    clinfo
    glxinfo
    vulkan-tools
    gpu-viewer
    gnupg
    gitFull
    pinentry-all
    flatpak
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

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.05";
}
