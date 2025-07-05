{inputs, user, pkgs, ...}: {
    # wayland.windowManager.hyprland = {
    #     enable = true;
    #     package = inputs.hyprland.packages.${user.info.system}.hyprland;
    #     # portalPackage = inputs.hyprland.packages.${user.info.system}.xdg-desktop-portal-hyprland;
    #     xwayland.enable = true;
    # };
    home.packages = [
        (pkgs.writeShellScriptBin "hypr-switch" ''
            set -eu
            theme="$1"
            ln -sf "$HOME/.config/hypr/theme/''${theme}.conf" \
                   "$HOME/.config/hypr/hyprland.conf"
            hyprctl reload
        '')
    ];

    xdg.configFile."${user.location.home}/.config/hypr/theme/default.conf".source = ../../../modules/homeManagerModules/hyprland/theme/default.conf;
    xdg.configFile."${user.location.home}/.config/hypr/theme/work.conf".source = ../../../modules/homeManagerModules/hyprland/theme/work.conf;

    home.file."${user.location.home}/.config/hypr/hyprland.conf".source = ../../../modules/homeManagerModules/hyprland/hyprland.conf;
}
