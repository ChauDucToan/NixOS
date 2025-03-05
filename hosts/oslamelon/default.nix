{ config, lib, inputs, user, pkgs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../systemConfig/global
        ../systemConfig/optional/docker.nix
        ../systemConfig/optional/mpd.nix
        ../systemConfig/optional/gamemode.nix
        ../systemConfig/optional/mysql.nix
        ../systemConfig/optional/tmux.nix
        ../systemConfig/optional/virtMachine.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

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

        postgresql

        jdk17
        nodejs_22
        texliveFull
            
        gtk4
        mangohud
        protonup
        bottles
        winetricks
        wineWowPackages.stable
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

        lf

        swappy
        mako
        dunst
        grim
        slurp
        rofi
        dbus
        vscode
    ];
    
    programs.nix-ld.enable = true;
}
