{mkLazyPlugin, pkgs}: {
    plugins = [
        (mkLazyPlugin {
            name = "lervag/vimtex";
            lazy = false;
            dependencies = [ pkgs.zathura ];
            init = ''
                -- Make zathura default latex viewer method
                vim.g.vimtex_view_method = "zathura"

                -- Make latexmk default compiler
                vim.g.vimtex_compiler_method = "latexmk"
            '';
        })
        (mkLazyPlugin {
            name = "preservim/vim-markdown";
        })
        (mkLazyPlugin {
            name = "numToStr/Comment.nvim";
        })
        (mkLazyPlugin {
            name = "ThePrimeagen/vim-be-good";
            lazy = true;
        })
        (mkLazyPlugin {
            name = "ibhagwan/fzf-lua";
            lazy = false;
            extraConf = ''
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = {},
            '';
        })
        (mkLazyPlugin {
            name = "Dan7h3x/neaterm.nvim";
            lazy = false;
            extraConf = ''
                branch = "stable",
                event = "VeryLazy",
                opts = {
                  -- Your custom options here (optional)
                },
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "ibhagwan/fzf-lua",
                },
            '';
        })
        (mkLazyPlugin {
            name = "Bekaboo/deadcolumn.nvim";
            init = ''
                require("deadcolumn").setup({
                    scope = function()
                        local max = 0
                        for i = -50, 50 do
                            local len = vim.fn.strdisplaywidth(vim.fn.getline(vim.fn.line('.') + i))
                            if len > max then
                                max = len
                            end
                        end
                        return max
                    end,
                    modes = function(mode)
                        return mode:find('^[ictRss\x13]') ~= nil
                    end,
                    blending = {
                        threshold = 0.75,
                        colorcode = '#000000',
                        hlgroup = { 'Normal', 'bg' },
                    },
                    warning = {
                        alpha = 0.4,
                        offset = 0,
                        colorcode = '#FF0000',
                        hlgroup = { 'Error', 'bg' },
                    },
                    extra = {
                        follow_tw = "80",
                    },
                })

                vim.opt.colorcolumn = "80"
                vim.cmd([[ set termguicolors ]])
            '';
        })
    ];
}
