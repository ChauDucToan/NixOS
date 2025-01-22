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
            lazy = false;
        })
    ];
}
