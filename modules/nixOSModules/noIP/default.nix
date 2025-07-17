{config, lib, pkgs, ...}: with lib;
let
    noipDuc = pkgs.callPackage ./noIP.nix {};
    cfg = config.services.noipDuc;
in {
    options.services.noipDuc = {
        enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable the No-IP DUC systemd service.";
        };

        username = mkOption {
            type = types.str;
            default = "";
            description = "No-IP account username.";
        };

        password = mkOption {
            type = types.str;
            default = "";
            description = "No-IP account password.";
        };

        hostnames = mkOption {
            type    = types.listOf types.str;
            default = [];
            description = "List of hostnames or host-groups to update (comma-separated internally).";
        };

        checkInterval = mkOption {
            type    = types.str;
            default = "5m";
            description = "How often to poll/check for IP changes (e.g. \"5m\", \"10s\").";
        };

        logLevel = mkOption {
            type    = types.str;
            default = "info";
            description = "NOIP_LOG_LEVEL for the client (debug, info, warn, error).";
        };
    };
    
    config = mkIf (cfg.enable == true) {
        environment.systemPackages = [ noipDuc ];

        environment.etc."default/noip-duc".text = ''
            NOIP_USERNAME=${cfg.username}
            NOIP_PASSWORD=${cfg.password}
            NOIP_HOSTNAMES=${(concatStringsSep ";" cfg.hostnames)}
            NOIP_CHECK_INTERVAL=${cfg.checkInterval}
            NOIP_LOG_LEVEL=${cfg.logLevel}
        '';

        systemd.services.noip-duc = {
            description = "No-IP Dynamic Update Client"; 
            wants       = [ "network-online.target" ];
            after       = [ "network-online.target" "auditd.service" ];

            serviceConfig = {
                Type       = "simple";
                ExecStart  = "${noipDuc}/bin/noip-duc -g all.ddnskey.com --username ${cfg.username} --password ${cfg.password}
";
                EnvironmentFile = "/etc/default/noip-duc";
                Restart = "on-failure";
            };
            wantedBy = [ "multi-user.target" ];
        };
    };
}
