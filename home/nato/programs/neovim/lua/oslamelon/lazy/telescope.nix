{pkgs, lib, user,...}: 
let
    username = "${user.info.username}";
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/lazy/telescope.lua".text = ''
        return {
            "nvim-telescope/telescope.nvim",
            branch = '0.1.x',
            lazy = false,
            dependencies = { "nvim-lua/plenary.nvim" },

            config = function()
                require('telescope').setup({})
                local builtin = require 'telescope.builtin'
                vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = "[S]earch [F]iles"})
                vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            end

        }
        '';
}
