{inputs, user, ...}: {
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${user.info.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${user.info.system}.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
    };

    home.file."${user.location.home}/.config/hypr".source = ../../../modules/homeManagerModules/hyprland;
}
