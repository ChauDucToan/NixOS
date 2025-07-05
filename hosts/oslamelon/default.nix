{ config, lib, inputs, user, pkgs, ... }: {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../systemConfig/global
        ../systemConfig/optional/docker.nix
        # ../systemConfig/optional/mpd.nix
        ../systemConfig/optional/gamemode.nix

        (import ../systemConfig/optional/sddm.nix {
            inherit pkgs lib;
            themeName = "where_is_my_sddm_theme";
            themePackage = pkgs.where-is-my-sddm-theme.override {
                themeConfig.General = {
                    background = toString ../../background/dock.png;
                    backgroundMode = "fill";
                };
            };

            isWayland = true;
            dependencies = with pkgs; [ 
                kdePackages.qt5compat
                kdePackages.qtdeclarative
            ];

        })

        # ../systemConfig/optional/mysql.nix
        # ../systemConfig/optional/tmux.nix
        ../systemConfig/optional/virtMachine.nix
        ../systemConfig/optional/heroic.nix
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
    services.displayManager.sddm = {
        enable = true;
    };

    # Configure keymap in X11
    services.xserver.xkb.layout = "us";

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        openssh
        libmad
        libGLU
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

        jetbrains.pycharm-professional
        ruff
        conda

        boost
        libgcc
        gcc14

        jdk17
        nodejs_24
        texliveFull
        nest-cli
        nest-mpi
            
        gtk4
        openssl
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
        dunst
        grim
        slurp
        rofi
        dbus

        wireguard-tools
    ] ++ [
        arduino
        screen
    ];
    
    programs.nix-ld.enable = true;

    programs.gamescope = {
        enable = true;
        capSysNice = true;
    };

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
    ];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ 51820 ];
    # networking.firewall.logRefusedUnicastsOnly = false;
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    # networking.wireguard.enable = true;
    # 
    # networking.wireguard.interfaces.wg0 = {
    #     ips = [ "10.0.0.2/24" ]; # IP phía client
    #     listenPort = 51820;
    #     privateKeyFile = "/home/oslamelon/wireguard-keys/private";

    #     peers = [
    #         {
    #             publicKey = "pWaI5xjGZ9HaRm67eKXzovBH4a7PyG64Cbty8yJ0OVM=";
    #             endpoint = "35.234.31.188:51820"; # địa chỉ IP hoặc domain server
    #             allowedIPs = [ "0.0.0.0/0" ]; # định tuyến toàn bộ lưu lượng
    #             persistentKeepalive = 25;
    #         }
    #     ];
    # };
}
