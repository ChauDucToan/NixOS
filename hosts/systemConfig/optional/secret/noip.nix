{ pkgs, ...}: {
    imports = [ ../../../../modules/nixOSModules/noIP ];

    config.services.noipDuc = {
        enable = true;
        username = "";
        password = "";
        hostnames = [
            ""
        ];
    };
}
