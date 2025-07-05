{ inputs, config, user, pkgs, ... }: {
    imports = [
        ../homeConfig/global
        ../homeConfig/optional/libreOffice.nix
        ../homeConfig/optional/nautilus.nix
        ../homeConfig/optional/obs.nix
        ../homeConfig/optional/osu.nix
        ../homeConfig/optional/brave.nix
        ../homeConfig/optional/keepassxc.nix
        ../homeConfig/optional/obsidian.nix
        ../homeConfig/optional/vscode.nix
        ../homeConfig/optional/appflowy.nix
        ../homeConfig/optional/astah-uml.nix
    ];

    home = {
        packages = with pkgs; [
            mpv
            fastfetch
            syncthing
            anydesk

            (writeShellScriptBin "my-hello" ''
                echo "Hello, ${config.home.username}!"
            '')
        ];
    };
}
