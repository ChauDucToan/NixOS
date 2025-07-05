{ pkgs? import <nixpkgs> {} }: {
    astah = pkgs.callPackage ./astah.nix {};
}
