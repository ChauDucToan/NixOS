{ config, lib, pkgs, ... }:

{
  hardware.pulseaudio.enable = false;

  sound.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    # packages = [ ];

    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };


}
