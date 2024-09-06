# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, pkgs, pkgs-unstable, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./gnome.nix
      ./hardware-configuration.nix
      ./pipewire.nix
      ./hyprland.nix
      ./xdg.nix
    ];

  options = {
    ton.maths.linfunc = lib.mkOption {
      type = lib.types.number;
      default = 0;
    };
  };

  config = {
    ton.maths.linfunc = 100;
    # Set up flakes permanently
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Setup keyfile
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    boot.loader.grub.enableCryptodisk = true;

    boot.initrd.luks.devices."luks-3c85b801-8aa3-4fcf-81ea-c68e1a7942a3".keyFile = "/crypto_keyfile.bin";
    networking.hostName = "oslamelon"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Ho_Chi_Minh";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "vi_VN";
      LC_IDENTIFICATION = "vi_VN";
      LC_MEASUREMENT = "vi_VN";
      LC_MONETARY = "vi_VN";
      LC_NAME = "vi_VN";
      LC_NUMERIC = "vi_VN";
      LC_PAPER = "vi_VN";
      LC_TELEPHONE = "vi_VN";
      LC_TIME = "vi_VN";
    };

    environment.sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "0";
    };

    hardware = {
      # Opengl
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      # Most wayland compositors need this
      nvidia.modesetting.enable = true;
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with ALSA.
    # sound.enable = true;
    # boot.extraModprobeConfig = ''
    #   options snd slots=snd-hda-intel
    # '';

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.oslamelon = {
      isNormalUser = true;
      description = "Oslamelon";
      extraGroups = [ "networkmanager" "wheel" ];
      # openssh.authorizedKeys.keys = [
      # Replace with your own public key
      # "ssh-ed25519 <some-public=key> oslamelon@oslamelon-pc
      # ];
      packages = with pkgs; [
      ];
    };

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    documentation.nixos.enable = false;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      nix
      git # Install git
      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      ripgrep
      neofetch
      # pkgs.home-manager

      wget # Need for mason.nvim
      curl # Need for mason.nvim
      gnutar
      gzip
      nodejs
      cargo
      unzip
      python3
      ffmpeg
      libreoffice-qt6-fresh
      mpv
      gcc
      ncurses
      bottles

      gtk4
      (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
      )
      # hyprland

      vencord
      neovim # Install neovim
      thunderbird
      obsidian # Install obsidian
      calibre
      obs-studio
      nerdfonts
      swappy
      lf
      kitty
      dunst
      mako
      systemd
      swww
      rofi-wayland
      vesktop
      anki
      virtualbox
      grim # screenshot
      slurp # screen area selection
      wl-clipboard

      ibus
      ibus-engines.bamboo
    ] ++ (with pkgs-unstable; [
      # hyprland
      libinput
      aquamarine
    ]);

    # Set default editor to vim

    # environment.variables.EDITOR = "vim";
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Install telex for Linux
    i18n.inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        bamboo
      ];
    };



    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh = {
    #     enable = true;
    #     settings = {
    #      X11Forwarding = true;
    #      PermitRootLogin = "no"; # disable root login
    #      PasswordAuthenciation = false; # disable password login
    #   };
    #   openFirewall = true;
    # };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
