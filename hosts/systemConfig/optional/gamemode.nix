{pkgs, ...}: {
    programs.gamemode = {
        enable = true;
        settings = {
            general = {
                softrealtime = "on";
                inhibit_screensaver = 1;
            };

            custom = {
                start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
                end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
            };
        };
    };
}
