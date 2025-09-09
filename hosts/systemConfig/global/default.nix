{user,...}: {
    imports = [
        ./fcitx.nix
        ./fonts.nix
        ./locale.nix
        ./nix.nix
        ./pipewire.nix
        ./hyprland.nix
    ];

    nixpkgs.config.allowUnfree = true;
    users.users.${user.info.username} = {
        isNormalUser = true;
        extraGroups = [ "dialout" "uucp" "networkmanager" "wheel" "gamemode" ];
        uid = 1000;
    };

    networking.hostName = user.info.hostname;
    networking.networkmanager.enable = true;

    system.stateVersion = user.info.stateVersion;
}
