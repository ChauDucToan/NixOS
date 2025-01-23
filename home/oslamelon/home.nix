{ inputs, config, user, pkgs, ... }:
let
    username = "${user.info.username}";
    home = "/home/${username}";
    conf = "${home}/.config/";
in {
    imports = [
        # ./modules
        ./config
        ./programs
    ];

    home = {
        username = username;
        homeDirectory = home;

        # Home Manager can also manage your environment variables through
        # 'home.sessionVariables'. These will be explicitly sourced when using a
        # shell provided by Home Manager. If you don't want to manage your shell
        # through Home Manager then you have to manually source 'hm-session-vars.sh'
        # located at either
        #
        #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        #
        # or
        #
        #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
        #
        # or
        #
        #  /etc/profiles/per-user/oslamelon/etc/profile.d/hm-session-vars.sh
        #
        sessionVariables = {
            GTK_IM_MODULE = "fcitx";
            QT_IM_MODULE = "fcitx";
            SDL_IM_MODULE= "fcitx";
            GLFW_IM_MODULE="ibus";
            XMODIFIERS = "@im=fcitx";
        };

        packages = with pkgs; [
            # # It is sometimes useful to fine-tune packages, for example, by applying
            # # overrides. You can do that directly here, just don't forget the
            # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
            # # fonts?
            # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

            staruml
            mpv
            obsidian
            nautilus
            fastfetch
            firefox
            vesktop
            obs-studio
            libreoffice-qt6-fresh

            (writeShellScriptBin "my-hello" ''
                echo "Hello, ${config.home.username}!"
            '')

            (writeShellScriptBin "my-md-template" (
                builtins.readFile ../../conf/Bin/makeTemplatesmd.bash)
            )
        ];

        # Home Manager is pretty good at managing dotfiles. The primary way to manage
        # plain files is through 'home.file'.
        file = {
            # # Building this configuration will create a copy of 'dotfiles/screenrc' in
            # # the Nix store. Activating the configuration will then make '~/.screenrc' a
            # # symlink to the Nix store copy.

            # "${conf}nvim/init.lua".source = ../conf/nvim/init.lua;
            # "${conf}nvim/lua".source = ../conf/nvim/lua;
            "${conf}waybar".source = ../../conf/waybar;
            "${conf}kitty".source = ../../conf/kitty;
            "${conf}hypr".source = ../../conf/hypr;

            # # You can also set the file content immediately.
            # ".gradle/gradle.properties".text = ''
            #   org.gradle.console=verbose
            #   org.gradle.daemon.idletimeout=3600000
            # '';
        };


        stateVersion = "24.05";
    };

    # systemd.user.enable = true;


    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
