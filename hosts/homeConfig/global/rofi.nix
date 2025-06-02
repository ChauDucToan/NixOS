
{inputs, user, pkgs, ...}: {
    home.packages = with pkgs; [ kitty ];

    home.file."${user.location.home}/.config/rofi".source = ../../../modules/homeManagerModules/rofi;
}
