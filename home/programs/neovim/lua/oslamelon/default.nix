{pkgs, lib, user,...}:
{
    imports = [
        ./init.nix
        ./remap.nix
        ./set.nix
        ./lazy
    ];
}
