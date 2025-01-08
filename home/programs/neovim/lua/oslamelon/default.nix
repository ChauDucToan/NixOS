{pkgs, lib, username,...}:
{
    imports = [
        ./init.nix
        ./remap.nix
        ./set.nix
        ./lazy
    ];
}
