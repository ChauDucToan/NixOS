{pkgs, inputs, ...}:
let
    astah = pkgs.callPackage ../../../modules/homeManagerModules/Astah/astah.nix {};
in
{
    home.packages = [ 
        astah
    ];
}
