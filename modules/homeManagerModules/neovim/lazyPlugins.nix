{lib, user}: {
    mkLazyPlugin = { name, lazy ? true, init ? "", extraConf? "", dependencies ? []}: {
        pkgsDependencies = dependencies;

        configFile = {
            target = "/home/${user.info.username}/.config/nvim/lua/${user.info.hostname}/lazy/${lib.lists.last (lib.strings.splitString "/" name)}.lua";
            text = ''
                return {
                    "${name}",
                    lazy = ${lib.boolToString lazy},
                    ${lib.optionalString (extraConf != "") ''
                        ${extraConf}
                    ''}
                    ${lib.optionalString (init != "") ''
                    init = function()
                        ${init}
                    end
                    ''}
                }
            '';
        };
    };
}
