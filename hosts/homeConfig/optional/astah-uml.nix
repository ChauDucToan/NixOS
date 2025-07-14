{pkgs, inputs, ...}:
let
    astah = pkgs.callPackage ../../../modules/homeManagerModules/astah_uml/astah.nix {};
in
{
    home.packages = [ 
        astah
    ];
}
