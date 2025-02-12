{pkgs, lib, inputs, ...}: {
    imports = [
        inputs.nvf.homeManagerModules.default
    ];

    programs.nvf = {
        enable = true;

        settings = {
            vim = {
                theme = {
                    enable = true;
                    name = "gruvbox";
                    style = "dark";
                };

                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;

                languages = {
                    enableLSP = true;
                    enableTreesitter = true;

                    nix.enable = true;
                    clang = {
                        enable = true;
                        cHeader = true;
                        lsp = {
                            enable = true;
                        };
                    };
                    rust.enable = true;
                };
            };
        };
    };
}
