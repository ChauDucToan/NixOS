{ config, lib, inputs, user, pkgs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    networking.hostName = "${user.info.username}" + "-nix"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [ 
                vaapiIntel
                intel-ocl
                intel-media-driver
                libvdpau-va-gl
                nvidia-vaapi-driver
            ];
        };

        nvidia = { 
            modesetting.enable = true;
            open = false;
            nvidiaSettings = true;
            powerManagement = {
                enable = false;
                finegrained = false;
            };

            prime = {
                sync.enable = true;
                
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
            };
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            forceFullCompositionPipeline = true;
        };

        cpu.intel.updateMicrocode = true;
    };

    boot.kernelParams = [
        "i915.enable_psr=0"       
        "i915.enable_guc=2"       
        "i915.enable_fbc=1"       
    ];

    nixpkgs.config.nvidia.acceptLicense = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "nvidia" "modesetting" ];

    # Enable the SDDM Desktop Environment.
    services.displayManager.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Configure keymap in X11
    services.xserver.xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${user.info.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "gamemode" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [ ];
        uid = 1000;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        openssh
        libmad

        libGLU
        linuxKernel.packages.linux_xanmod_latest.nvidia_x11
        linuxKernel.packages.linux_xanmod_latest.system76
        linuxKernel.packages.linux_xanmod_latest.system76-io
        cudaPackages.libnvidia_nscq
        nvidia-vaapi-driver
        nvidia_oc
        nvidia_cg_toolkit
        nvidia-optical-flow-sdk
        nvidia-texture-tools

        dotnet-sdk
        wineWowPackages.waylandFull
        cachix

        mesa-demos
        mesa
        vulkan-headers 
        vulkan-loader
        vulkan-tools

        wget
        curl
        ripgrep
        gzip
        rar
        gnutar
        unzip
        cargo
        ffmpeg
        fmt
        ninja
        tlp

        cmake
        extra-cmake-modules
        gnumake
        gdb

        luajitPackages.luarocks
        lua51Packages.lua

        go

        python3
        conda

        boost
        libgcc
        gcc14

        docker
        docker-compose

        postgresql

        jdk17
        nodejs_22
        texliveFull
            
        gtk4
        mangohud
        protonup
        bottles
    ] ++ [
        mpc
        pavucontrol
        ncmpcpp
        rmpc

        egl-wayland
        kdePackages.wayland-protocols
        xwayland

        wl-clipboard
        waybar

        kitty

        lf

        swappy
        mako
        dunst
        grim
        slurp
        swww
        rofi
        dbus
    ];

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${user.info.system}.hyprland;
        xwayland.enable = true;
    };

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    system.stateVersion = "24.05"; # Did you read the comment?
}
