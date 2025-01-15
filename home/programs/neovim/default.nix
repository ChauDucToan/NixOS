{pkgs, lib, inputs, user, ...}: 
let
    conf = "/home/${user.info.username}/.config/nvim/";
in {
    imports = [
        ./lua
    ];

    home.file."${conf}init.lua".text = ''
        require("${user.info.username}.remap")
        require("${user.info.username}.set")
        require("${user.info.username}")
    '';
}
