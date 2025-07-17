{ config, pkgs, ... }: {
    users = {
        users = {
            "khat" = {
                isNormalUser = true;
                home         = "/home/khat";
                homeMode     = "700";
                createHome   = true;
                extraGroups  = [ "slave" ];
                shell = pkgs.bash;
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtPd+7h+1aOwx7j9APlr4BcD93w+eFmJWs+1TgRoDhU khat@oslamelon.ddns.net"
                ];
            };
        };
        groups = {
            "slave" = { };
        };
    };
}

