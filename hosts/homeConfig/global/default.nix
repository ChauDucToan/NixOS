{user,...}: {
    imports = [
        ./cursor.nix
        ./discord.nix
        ./firefox.nix
        ./hyprland.nix
        ./neovim.nix
        ./wallpaper.nix
    ];

    programs = {
        # Let Home Manager install and manage itself.
        home-manager.enable = true;
        git.enable = true;
    };

    home = {
        username = user.info.username;
        homeDirectory = user.location.home;
        stateVersion = user.info.stateVersion;
    };

    users.users.${user.info.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "gamemode" ];
        uid = 1000;
    };
}
