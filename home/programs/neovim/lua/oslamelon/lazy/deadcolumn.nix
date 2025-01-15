{pkgs, lib, user,...}: 
let
    username = "${user.info.username}";
    conf = "/home/${username}/.config/nvim/";
    filename = "deadcolumn";
in {
    home.file."${conf}lua/${username}/lazy/${filename}.lua".text = ''
        return {
            "Bekaboo/${filename}.nvim",
            config = function()
                require("${filename}").setup({
                    ---@type string|fun(): integer
                    ---@type string[]|fun(mode: string): boolean
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
                        ---@type string?
                        follow_tw = "80",
                    },
                })

                vim.opt.colorcolumn = "80"
                vim.cmd([[ set termguicolors ]])
            end
        }
        '';
}
