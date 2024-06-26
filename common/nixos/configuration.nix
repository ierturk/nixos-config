{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # ../modules/wireguard.nix
    # ../packages/nomachine/nomachine.nix
    ../modules/home-manager.nix
    ../modules/hyprland.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

    # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    # settings.General.DisplayServer = "x11-user";
  };

  # services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable automatic login for the user.
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "me";
  ### Workaround for autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  ### Various tests
  # services.displayManager.defaultSession = "none+icewm";
  # services.xserver.windowManager.icewm.enable = true;
  ###

  ### SwayWM
  # services.gnome.gnome-keyring.enable = true;
  # enable sway window manager
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };
  ### End of SwayWM

  # services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  users.users = {
    me = {
      isNormalUser = true;
      description = "Ibrahim Erturk";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "wireshark" "podman" "video" ];
    };
  };


  ### Plasma browser integration fix
  environment.etc."opt/edge/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${pkgs.kdePackages.plasma-browser-integration}/etc/opt/edge/native-messaging-hosts/org.kde.plasma.browser_integration.json";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
    pciutils
    usbutils
    inxi
    parted
    lshw
    nix-index
    wireguard-tools
    nmap
    # pulseaudio-module-xrdp

    ### sddm background
    (writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
        background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/OneStandsOut/contents/images/2560x1600.jpg
    '')
    ### end of sddm background

    ### NoMachine server
    # (pkgs.callPackage ../../common/packages/nomachine/default.nix {})

    distrobox
    podman
    dive
    podman-tui
    podman-compose
    # podman-desktop
    # toolbox

    networkmanager

    # xorg.xhost
    # xorg.xdpyinfo
    # wayvnc
    # xwayland-run

    ### SwayWM
    # grim # screenshot functionality
    # slurp # screenshot functionality
    # wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    # mako # notification system developed by swaywm maintainer

    libsForQt5.qt5.qtwayland
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Virtualization
  services.flatpak.enable = true;
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  hardware.logitech.wireless.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # programs.direnv.enable = true;
  programs.wireshark.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  # XRDP service
  # services.xrdp = {
  #   enable = true;
  #   defaultWindowManager = "startplasma-x11";
  #   openFirewall = true;
  #   port = 3389;
  #   audio.enable = true;
  # };

  ### NX server
  # services.nxserver.enable = false;
  ## server settings
  # services.nxserver.serverSettings.EnableDebug = true;
  # services.nxserver.serverSettings.SessionLogLevel = 9;
  ## node settings
  # services.nxserver.nodeSettings.EnableDebug = true;
  # services.nxserver.nodeSettings.SessionLogLevel = 9;
  # services.nxserver.nodeSettings.EnableEGLCapture = true;
  # open port
  # networking.firewall.allowedTCPPorts = [ 4000 5353 ];

  ### VayVnc
  networking.firewall.allowedTCPPorts = [ 5900 ];

  system.stateVersion = "24.05";
}
