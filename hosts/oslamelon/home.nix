{ inputs, config, user, pkgs, ... }: {
    imports = [
    ];

    home = {
        packages = with pkgs; [
            mpv
            fastfetch

            (writeShellScriptBin "my-hello" ''
                echo "Hello, ${config.home.username}!"
            '')

            (writeShellScriptBin "my-md-template" (
                builtins.readFile ../../conf/Bin/makeTemplatesmd.bash)
            )
        ];
    };
}
