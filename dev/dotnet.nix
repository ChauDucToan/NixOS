{ pkgs ? import <nixpkgs> {}, user, ...}@inputs:
pkgs.mkShell rec{
    name = "dotnet-env";

    dotnet-pkgs = (with pkgs.dotnetCorePackages; combinePackages [
        dotnet_9.sdk
        dotnet_8.sdk
    ]);

    deps = [
        pkgs.zlib
        pkgs.zlib.dev
        pkgs.openssl
        dotnet-pkgs
    ];

    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath ([
        pkgs.stdenv.cc.cc
    ] ++ deps);
    NIX_LD = "${pkgs.stdenv.cc.libc_bin}/bin/ld.so";

    nativeBuildInputs = [] ++ deps;

    shellHook = ''
        DOTNET_ROOT="${dotnet-pkgs}";
    '';
}
