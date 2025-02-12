{inputs, user, ...}: {
    programs.waybar.enable = true;

    home.file."${user.location.home}/.config/waybar".source = ../../../modules/homeManagerModules/waybar/anby;
}
