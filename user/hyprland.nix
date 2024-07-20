{ config, inputs, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    waybar &

    swww-daemon &

    swww img /Pictures/highres-Elaina.jpg &

    dunst
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    plugins = [
      # inputs.hyprland-hyprspace.packages.${pkgs.system}.default
      # plugins.hyprexpo
      # plugins.hyprbars
      # plugins.borderspp
    ];

    settings = {

      exec-one = ''${startupScript}/bin/start'';

      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      bind = [
        # keyboard binding
        "$mod, T, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, R, exec, $menu"
        "$mod, M, exit,"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}

