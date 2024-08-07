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
    ../modules/greetd.nix
  ];

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
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "wireshark" "podman" "video" "input" "dialout" ];
    };
  };

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

    python3

    ### NoMachine server
    # (pkgs.callPackage ../../common/packages/nomachine/default.nix {})

    distrobox
    podman
    dive
    podman-tui
    podman-compose

    polkit_gnome
    libsecret

    matlab
  ];

  ### ssh service
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  ### Hyprland
  # VayVnc
  networking.firewall.allowedTCPPorts = [ 5900 ];

  # flatpak
  services.flatpak.enable = true;

  # password management
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.ssh.startAgent = true;
  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
    config = {
      preferred = {
        default = [
          "wlr"
          "hyprland"
        ];
      };
    };
  };
  # Electron fix
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  # Font config
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    font-awesome
    (pkgs.nerdfonts.override {
      fonts = [
        "Meslo"
      ];
    })
  ];

  # Virtualization
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

  programs.wireshark.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-curses;
  };

  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  programs.vim.defaultEditor = true;

  system.stateVersion = "24.05";
}
