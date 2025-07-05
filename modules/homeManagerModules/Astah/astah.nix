{ pkgs ? import <nixpkgs> {} }:
let
    inherit (pkgs) stdenv jdk dpkg makeWrapper lib fetchurl;
in
stdenv.mkDerivation rec {
    pname    = "astah-uml";
    version  = "10.1.0.9ceee1-0_all";

    src = fetchurl {
        url = "https://cdn.change-vision.com/files/${pname}_${version}.deb";
        sha256 = "sha256-4dajuhIyKv18qPlhEKkTMBkcsKjFxZNCvKT3aQrqMGo=";
    };

    nativeBuildInputs = [ dpkg makeWrapper ];

    BuildInputs = [ jdk ];

    dontConfigure = true;
    dontBuild     = true;

    unpackPhase = ''
        runHook preUnpack
        dpkg-deb -x $src .
        runHook postUnpack
    '';

    installPhase = ''
        runHook preInstall
        mkdir -p $out

        cp -r usr $out/

        mkdir -p $out/bin
        makeWrapper $out/usr/lib/astah_uml/astah-uml \
          $out/bin/astah-uml \
          --set JAVA_HOME ${jdk}/lib/openjdk \
          --prefix PATH : ${lib.makeBinPath [ jdk ]}
        runHook postInstall
    '';

    meta = with pkgs.lib; {
        description = "Astah UML – Công cụ mô hình hóa UML đa nền tảng";
        homepage    = "https://astah.net/";
        license     = licenses.unfree;
        platforms   = platforms.linux;
        maintainers = with maintainers; [ "ChauDucToan" ];
    };
}
