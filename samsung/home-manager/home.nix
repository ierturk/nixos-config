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
    kdePackages.kate
    microsoft-edge
    vscode
    spotify
    solaar
    vlc
    gnupg
    kdePackages.kwallet-pam
    kdePackages.bluedevil
    kdePackages.plasma-browser-integration
    flatpak
    kdePackages.discover
    # nomachine-client
    wireshark
    gitFull
    pinentry-all
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
