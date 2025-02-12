{pkgs,...}: {
    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;

        fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
                fcitx5-unikey
                fcitx5-with-addons
            ];
        };
    };

    environment.sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        SDL_IM_MODULE= "fcitx";
        GLFW_IM_MODULE="ibus";
        XMODIFIERS = "@im=fcitx";
    };
}
