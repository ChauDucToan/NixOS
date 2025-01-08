{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/vimmarkdown.lua".text = ''
        return {

            "preservim/vim-markdown",
            config = function()
            end,

        }
        '';
}
