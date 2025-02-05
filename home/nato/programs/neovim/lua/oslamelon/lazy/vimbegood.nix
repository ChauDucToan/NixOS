{pkgs, lib, user,...}: 
let
    username = "${user.info.username}";
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/vimbegood.lua".text = ''
        return {

            "ThePrimeagen/vim-be-good",
            lazy = false,

        }
        '';
}
