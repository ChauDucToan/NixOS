{ pkgs ? import <nixpkgs> {}, ...}@inputs:

pkgs.mkShell
{
    nativeBuildInputs = with pkgs; [
        clang
        gcc
        clang-tools
    ];

    shellHook = ''
        echo "Hello oslamelon"
        cd ~/Desktop/C/
        echo "to my shell!!!!" | ${pkgs.cowsay}/bin/cowsay
    '';
}
