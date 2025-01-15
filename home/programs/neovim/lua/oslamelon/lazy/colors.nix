{pkgs, lib, user,...}: 
let
    username = "${user.info.username}";
    conf = "/home/${username}/.config/nvim/";
    color = "gruvbox";
in {
    home.file."${conf}lua/${username}/lazy/colors.lua".text = ''
        function ColorMyBackground(color)
            color = color or "${color}"
            vim.cmd.colorscheme(color)

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end

        return {

            {
                "folke/tokyonight.nvim",
                lazy = false,
                opts = {},
                config = function()
                    require("tokyonight").setup({
                        -- your configuration comes here
                        -- or leave it empty to use the default settings
                        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                        transparent = true, -- Enable this to disable setting the background color
                        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                        styles = {
                            -- Style to be applied to different syntax groups
                            -- Value is any valid attr-list value for `:help nvim_set_hl`
                            comments = { italic = false },
                            keywords = { italic = false },
                            -- Background styles. Can be "dark", "transparent" or "normal"
                            sidebars = "dark", -- style for sidebars, see below
                            floats = "dark", -- style for floating windows
                        },
                    })

                    ColorMyBackground()
                end
            },
            {

                "rose-pine/neovim",
                name = "rose-pine",
                config = function()
                    require('rose-pine').setup({
                        disable_background = true,
                        styles = {
                            italic = false,
                        },
                    })

                    ColorMyBackground();
                end

            },
            {
                "ellisonleao/gruvbox.nvim",
                config = function()
                    require("gruvbox").setup({
                        terminal_colors = false,
                        underline = true;
                        undercurl = true;
                        bold = true;
                        italic = {
                            strings = true,
                            emphasis = true,
                            comments = true,
                            operators = false,
                            folds = true,
                        },
                        strikethrough = true,
                        invert_selection = false,
                        invert_signs = false,
                        invert_tabline = false,
                        invert_intend_guides = false,
                        inverse = true, -- invert background for search, diffs, statuslines and errors
                        contrast = "", -- can be "hard", "soft" or empty string
                        palette_overrides = {},
                        overrides = {},
                        dim_inactive = false,
                        transparent_mode = false,
                    })

                    vim.o.background = "dark"
                    ColorMyBackground()
                end
            },
        }
        '';
}
