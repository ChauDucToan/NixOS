{user,...}: {
    imports = [
        ./fcitx.nix
        ./fonts.nix
        ./locale.nix
        ./nix.nix
        ./pipewire.nix
    ];

    networking.hostName = user.info.hostName;
    networking.networkmanager.enable = true;

    system.stateVersion = user.info.stateVersion;
}
