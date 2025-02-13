# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, user, pkgs, ... }:

    {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../systemConfig/global
        ../systemConfig/optional/docker.nix
        ../systemConfig/optional/printing.nix
        ../systemConfig/optional/mpd.nix
        ../systemConfig/optional/gamemode.nix
        ../systemConfig/optional/mysql.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Amd cpu and gpu tweaking
    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        cpu = {
            amd = {
                updateMicrocode = true;
                sev.enable = true;
                sevGuest.enable = true;
            };
        };

        amdgpu = {
            initrd.enable = true;
            amdvlk = {
                enable = true;
                support32Bit = {
                    enable = true;
                    package = pkgs.driversi686Linux.amdvlk;
                };
                supportExperimental.enable = true;
                package = pkgs.amdvlk;
                settings = {
                    AllowVkPipelineCachingToDisk = 1;
                    EnableVmAlwaysValid = 1;
                    IFH = 0;
                    IdleAfterSubmitGpuMask = 1;
                    ShaderCacheMode = 1;
                };
            };
            opencl = {
                enable = true;
            };
        };
    };
    services.auto-epp.enable = true;
    programs.tuxclocker.enableAMD = true;
    programs.ryzen-monitor-ng.enable = true;

    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "modesetting" ];

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vulkan-tools
        mesa
        libGLU

        go
        python314
        libgcc
        gcc14

        gtk4

        git
        gitless

        nix

        libnotify
        libjpeg
        cups
        ghostscript
        xsane
        sane-backends
        cups-pk-helper
        libusbp
        unzip

        wget # Need for mason.nvim
        curl # Need for mason.nvim

        fragments
        gparted
        nautilus
        komikku
        wike
        gaphor

        gnome-builder
        gnome-console
        gnome-decoder
        gnome-desktop
        gnome-bluetooth
        gnomeExtensions.kimpanel
        gnomeExtensions.cronomix
        gnomeExtensions.app-hider
        gnomeExtensions.alternate-menu-for-hplip2
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    
    # List services that you want to enable:
    
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    
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

}
