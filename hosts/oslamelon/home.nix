{ inputs, config, user, pkgs, ... }: {
    imports = [
        ../homeConfig/global
        ../homeConfig/optional/libreOffice.nix
        ../homeConfig/optional/nautilus.nix
        ../homeConfig/optional/obs.nix
        ../homeConfig/optional/osu.nix
        ../homeConfig/optional/brave.nix
        ../homeConfig/optional/obsidian.nix
    ];

    home = {
        packages = with pkgs; [
            mpv
            fastfetch

            (writeShellScriptBin "my-hello" ''
                echo "Hello, ${config.home.username}!"
            '')
        ];
    };
}
