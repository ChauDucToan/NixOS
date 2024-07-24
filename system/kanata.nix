{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kanata
  ];

  services.kanata = {
    enable = true;

    package = with pkgs; [
      kanata-with-cmd
    ];

    keyboards = { };
  };
}
