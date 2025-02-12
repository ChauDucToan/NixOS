{config, lib, pkgs, ...}: with lib; let
    cfg = config.services.swww;
    wallpaperPath = "${config.home.homeDirectory}/Pictures/${cfg.wallpaper}";
in {
    options.services.swww.enable = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Enable swww wallpaper program";
    };

    options.services.swww.wallpaper = mkOption {
        type = types.str;
        default = "anby.png";
        example = "wallpaper.jpg";
        description = "Select img from ~/Pictures";
    };

    config = mkIf cfg.enable {
        home.packages = [ pkgs.swww ];

        systemd.user.services.swww-set-wallpaper = {
            Unit = {
                Description = "Set wallpaper using swww";
                After = [ "graphical-session.target" ]; # Runs after login
            };
            Install = {
                WantedBy = [ "default.target" ];
            };
            Service = {
                ExecStart = "${pkgs.bash}/bin/bash -c 'if [ -f ${wallpaperPath} ]; then ${pkgs.swww}/bin/swww img ${wallpaperPath}; fi'";
            };
        };
    };
}
