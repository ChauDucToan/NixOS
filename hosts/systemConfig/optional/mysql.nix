{pkgs, user, ...}: {
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;

        user = "${user.info.username}";
        ensureUsers = [
            {
                name = "${user.info.username}";
                ensurePermissions = {
                    "${user.info.username}.*" = "ALL PRIVILEGES";
                };
            }
        ];

        ensureDatabases = [ 
            "${user.info.username}" 
        ];
    };
}
