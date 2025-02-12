{user,...}: {
    imports = [
        ./fcitx.nix
        ./fonts.nix
        ./locale.nix
        ./nix.nix
        ./pipewire.nix
    ];

    users.users.${user.info.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "gamemode" ];
        uid = 1000;
    };

    networking.hostName = user.info.hostname;
    networking.networkmanager.enable = true;

    system.stateVersion = user.info.stateVersion;
}
