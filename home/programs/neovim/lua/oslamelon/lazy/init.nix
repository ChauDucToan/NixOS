{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/init.lua".text = ''
        return {

            {
                "nvim-lua/plenary.nvim",
                name = "plenary"
            },

            "eandrju/cellular-automaton.nvim",
        }
        '';
}
