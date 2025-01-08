{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/treesitter.lua".text = ''
        return {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup({
                    -- A list of parser names, or "all"
                    ensure_installed = {
                        "java", "cpp", "c", "lua", "python", "bash"
                    }
                })
            end
        }
        '';
}
