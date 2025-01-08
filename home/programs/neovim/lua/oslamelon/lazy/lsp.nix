{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
    clangd = "${pkgs.llvmPackages_19.clang-unwrapped}/bin/clangd";
in {
    home.file."${conf}lua/${username}/lazy/lsp.lua".text = ''
        return {

            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", config = true },
                "williamboman/mason-lspconfig.nvim",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/nvim-cmp",
                "j-hui/fidget.nvim",

                -- opts = {} is the same as require("packet").setup({})
                { 'folke/neodev.nvim', opts = {} },
            },
            opts = {
                servers = {
                -- Ensure mason installs the server
                    clangd = {
                        keys = {
                            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                        },
                        root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja"
                        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
                          fname
                        ) or require("lspconfig.util").find_git_ancestor(fname)
                        end,
                        capabilities = {
                            offsetEncoding = { "utf-8", "utf-16" },
                        },
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                            "--fallback-style=llvm",
                        },
                        init_options = {
                            usePlaceholders = true,
                            completeUnimported = true,
                            clangdFileStatus = true,
                        },
                    },
                },
                setup = {
                    clangd = function(_, opts)
                        local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
                        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
                        return false
                    end,
                },
            },
            config = function()
                local cmp = require("cmp")
                local cmp_lsp = require("cmp_nvim_lsp")
                local capabilities = vim.tbl_deep_extend(
                    "force",
                    {},
                    vim.lsp.protocol.make_client_capabilities(),
                    cmp_lsp.default_capabilities()
                )

                require("fidget").setup({})
                require("mason").setup({})
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "bashls",
                        "jdtls",
                        
                        "textlsp",
                    },
                
                    handlers = {
                        function(server_name)
                            require("lspconfig")[server_name].setup {
                                on_attach = on_attach,
                                capabilities = capabilities
                            }
                        end,
                    }
                })

                local cmp_select = { behavior = cmp.SelectBehavior.Select }

                cmp.setup({
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                        ["<C-Space>"] = cmp.mapping.complete(),
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' }, -- For luasnip users.
                    }, {
                        { name = 'buffer' },
                    })
                })

                vim.diagnostic.config({
                    -- update_in_insert = true,
                    float = {
                        focusable = false,
                        style = "minimal",
                        border = "rounded",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                })
            end

        }
        '';
}
