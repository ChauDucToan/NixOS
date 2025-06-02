{pkgs, user, ...}: {
    services.postgresql = {
        enable = true;
        package = pkgs.postgresql;

        ensureUsers = [
            {
                name = "${user.info.username}";
                ensureClauses = {
                    superuser = true;
                    createdb = true;
                };
            }
            {
                name = "root";
                ensureClauses = {
                    superuser = true;
                    createrole = true;
                    createdb = true;
                };
            }
        ];

        settings = {
             port = 5432;
        };
    };
}
