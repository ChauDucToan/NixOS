{pkgs, lib, inputs, username, ...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    imports = [
        ./lua
    ];

    home.file."${conf}init.lua".text = ''
        require("${username}.remap")
        require("${username}.set")
        require("${username}")
    '';
}
