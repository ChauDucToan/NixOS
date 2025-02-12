{
    # make pipewire realtime-capable
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    security.polkit = {
        enable = true;
    };

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;

        lowLatency = {
            # enable this module
            enable = true;
            # defaults (no need to be set unless modified)
            quantum = 64;
            rate = 48000;
        };
    };
}
