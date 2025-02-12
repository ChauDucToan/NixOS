{inputs, user, pkgs, ...}: {
    home.packages = with pkgs; [ kitty ];

    home.file."${user.location.home}/.config/kitty".source = ../../../modules/homeManagerModules/kitty;
}
