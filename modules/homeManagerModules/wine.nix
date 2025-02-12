{pkgs, inputs, ...}: let
  nix-gaming = import (builtins.fetchTarball {
      url = "https://github.com/fufexan/nix-gaming/archive/master.tar.gz"; 
      sha256 = "0a21in6l6kvj92isn0ajlsj50x0bd11sfrzp0y3vkk1smgb360fh";
  });
in {

  home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
  ];
}
