{inputs, user, ...}: {
    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${user.info.system}.hyprland;
        xwayland.enable = true;
    };

    home.file."${user.location.home}/.config/hypr".source = ../../../modules/homeManagerModules/hyprland;
}
