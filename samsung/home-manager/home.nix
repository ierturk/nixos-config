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
    gnupg
    kdePackages.kwallet-pam
    kdePackages.bluedevil
    kdePackages.plasma-browser-integration
    flatpak
    kdePackages.discover
    gitFull
    pinentry-all
    ### Install from Discover by using Flatpak ( FlatHub )
    # nomachine-client
    # microsoft-edge
    # vscode
    # spotify
    # solaar
    # vlc
    # wireshark
    ### End of Discover
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
