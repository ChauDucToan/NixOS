{
    imports = [
        ./cursor.nix
        ./wallpaper.nix
    ];

    programs.home-manager.enable = true;
    home = {
        username = "nato";
        homeDirectory = "/home/nato";
        stateVersion = "24.05";
    };
}
