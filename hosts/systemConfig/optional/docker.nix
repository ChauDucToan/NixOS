{pkgs, ...} :{
    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };

        package = pkgs.docker;
        extraPackages = with pkgs; [
            docker-compose
        ];
    };
}
