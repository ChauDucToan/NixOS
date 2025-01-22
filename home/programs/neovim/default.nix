{pkgs, lib, inputs, user, ...}: 
let
    # Name and path of the config
    username = user.info.username;
    configPath = "/home/${username}/.config/nvim";

    pluginLib = import ./lazyPlugins.nix {inherit lib user;};
    plugins = import ./plugins.nix { mkLazyPlugin = pluginLib.mkLazyPlugin; inherit pkgs;};

    allDependencies = lib.lists.unique (lib.lists.flatten (map (p: p.pkgsDependencies) plugins.plugins));
    allConfigFiles = lib.lists.flatten (map (p: [p.configFile]) plugins.plugins);
in {
    imports = [
        ./lua/oslamelon
    ];

    home.packages = allDependencies;

    home.file = pkgs.lib.mkMerge [

        (lib.listToAttrs (map (cfg: {
            name = cfg.target;
            value = { inherit (cfg) text; };
        }) allConfigFiles ))

        {
            "${configPath}/init.lua".text = ''
                require("${username}.remap")
                require("${username}.set")
                require("${username}")
            '';
        }

    ];
}
