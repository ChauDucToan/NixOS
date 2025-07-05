{pkgs, lib, user,...}: 
let
    username = "${user.info.username}";
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/comment.lua".text = ''
        return {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true,
            opts = {},
        }
        '';
}
