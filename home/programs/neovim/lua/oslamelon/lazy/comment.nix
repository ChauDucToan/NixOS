{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/comment.lua".text = ''
        return {

            'numToStr/Comment.nvim',
            opts = {},


        }
        '';
}
