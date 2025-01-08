{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
in {
    home.file."${conf}lua/${username}/remap.lua".text = ''
        -- Set up leader keymap
        vim.g.mapleader = ' '

        -- Set keymap to execute Explore command in nvim
        vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = '[P]re[V]iew' })

        -- Move cursor into the middle
        vim.keymap.set("n", "<C-d>", "<C-d>zz")
        vim.keymap.set("n", "<C-u>", "<C-u>zz")

        -- Yank into system register
        vim.keymap.set("n", "<leader>y", "\"+y")
        vim.keymap.set("n", "<leader>Y", "\"+Y")
        vim.keymap.set("v", "<leader>y", "\"+y")

        vim.keymap.set("n", "<leader>f", "$V%zf")

        vim.keymap.set("n", "<leader>t", function()
            fileName = vim.fn.expand("%:t:r")
            vim.cmd(string.format('!my-md-template %s', fileName))
        end
        )


        --int main()  {
            -- for (int i = 0; i < fdsjafkls; i++) {
                --
                --
                --
                -- }
        --}
        '';
}
