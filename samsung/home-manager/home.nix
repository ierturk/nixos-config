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
    kdePackages.kate
    kdePackages.kwallet-pam
    kdePackages.bluedevil
    kdePackages.plasma-browser-integration
    kdePackages.flatpak-kcm
    # kdePackages.sddm-kcm
    kdePackages.discover
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
    ".gitconfig".source = ./dotfiles/gitconfig;
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
