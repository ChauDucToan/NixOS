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


--int main()  {
    -- for (int i = 0; i < fdsjafkls; i++) {
        --
        --
        --
        -- }
--} 
