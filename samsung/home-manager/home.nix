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
    wayland-utils
    egl-wayland
    aha
    clinfo
    glxinfo
    vulkan-tools
    gpu-viewer
    gnupg
    gitFull
    pinentry-all

    ###### KDE 6
    kdePackages.kate
    kdePackages.kwallet-pam
    kdePackages.bluedevil
    kdePackages.plasma-browser-integration
    kdePackages.flatpak-kcm
    kdePackages.discover
    kdePackages.krdp
    # kdePackages.sddm-kcm
    ######

    ###### KDE 5
    # libsForQt5.kate
    # libsForQt5.kwallet-pam
    # libsForQt5.bluedevil
    # libsForQt5.plasma-browser-integration
    # libsForQt5.flatpak-kcm
    # libsForQt5.discover
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
    ".gitconfig".source = ../../common/dotfiles/gitconfig;
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
