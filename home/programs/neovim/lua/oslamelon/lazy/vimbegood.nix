{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/vimbegood.lua".text = ''
        return {

            "ThePrimeagen/vim-be-good",
            lazy = false,

        }
        '';
}
