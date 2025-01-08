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
