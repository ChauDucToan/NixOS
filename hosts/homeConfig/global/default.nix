{user,...}: {
    imports = [
        ./bash.nix
        ./cursor.nix
        ./default.nix
        ./discord.nix
        ./firefox.nix
        ./hyprland.nix
        ./kitty.nix
        ./neovim.nix
        ./wallpaper.nix
        ./waybar.nix
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
}
