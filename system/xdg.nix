{ config, lib, pkgs, ... }:

{
  xdg = {
    autostart.enable = true;

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-hyprland
        # xdg-desktop-portal-gtk
      ];

      wlr.enable = true;
    };

    sounds.enable = true;
    mime.enable = true;
    menus.enable = true;
    icons.enable = true;
  };
}
