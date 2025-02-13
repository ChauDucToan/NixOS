{inputs, user, ...}: {
    # programs.waybar = {
    #     enable = true;
    #     systemd.enable = true;
    # };

    home.file."${user.location.home}/.config/waybar".source = ../../../modules/homeManagerModules/waybar/anby;
}
