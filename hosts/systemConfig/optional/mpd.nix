{config, user, pkgs, ...}: {
    environment.systemPackages = [ pkgs.mpd ];

    services.mpd = {
        enable = true;
        musicDirectory = "/home/${user.info.username}/Music";
        extraConfig = ''
            audio_output {
                type "pipewire"
                name "My PipeWire Output"
            }
        '';
        user = "${user.info.username}";
        network.listenAddress = "any"; # if you want to allow non-localhost connections
        startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    };

    systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${user.info.username}.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
    };
}

