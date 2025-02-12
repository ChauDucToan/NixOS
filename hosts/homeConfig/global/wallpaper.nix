{config, pkgs, lib, inputs, ...}:  {
    imports = [ ../../../modules/homeManagerModules/swww ];

    config.services.swww.enable = true;
    config.services.swww.wallpaper = "anby.png";
}
