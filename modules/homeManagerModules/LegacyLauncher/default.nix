{ pkgs? import <nixpkgs> {} }: {
  Legacy = pkgs.callPackage ./LegacyLauncher.nix {};
}
