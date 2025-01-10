{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
    name = "zathura";
    view_method = "${pkgs."${name}"}";
in {
    home.packages = [ "${view_method}" ];
    home.file."${conf}lua/${username}/lazy/vimtex.lua".text = ''
        return {
          "lervag/vimtex",
          lazy = false,
          init = function()
            
            -- Make zathura default latex viewer method
            vim.g.vimtex_view_method = "${name}"

            -- Make latexmk default compiler
            vim.g.vimtex_compiler_method = "latexmk"
            
          end
        }
        '';
}
