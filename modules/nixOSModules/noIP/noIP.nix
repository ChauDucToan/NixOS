{ pkgs ? import <nixpkgs> {}}: 
pkgs.rustPlatform.buildRustPackage rec {
    pname = "noip-duc";
    version = "3.3.0";

    src = builtins.fetchTarball {
        url = "https://dmej8g5cpdyqd.cloudfront.net/downloads/${pname}_${version}.tar.gz";
        sha256 = "sha256:1q7ai6b2n7jpfn9malx2v262v93ds0jq713lvzdz4v9ziaqv3j5a";
    };

    cargoHash = "sha256-IX1VrUvix50fFW9Pr6VxrpIhBBTkUuoNH+lXnA41I/4=";

    doCheck = false;

    meta = with pkgs.lib; {
        description = "Dynamic DNS update client for NO-IP.com";
        homepage    = "https://www.noip.com";
        license     = licenses.unfree;
        platforms   = platforms.linux;
        maintainers = with maintainers; [ "ChauDucToan" ];
    };
}
