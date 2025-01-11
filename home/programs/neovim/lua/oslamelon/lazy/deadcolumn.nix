{pkgs, lib, username,...}: 
let
    conf = "/home/${username}/.config/nvim/";
    filename = "deadcolumn";
in {
    home.file."${conf}lua/${username}/lazy/${filename}.lua".text = ''
        return {
            "Bekaboo/${filename}.nvim",
            config = function()
                require("${filename}").setup({
                    scope = 'line', ---@type string|fun(): integer
                    ---@type string[]|fun(mode: string): boolean
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
                        follow_tw = nil,
                    },
                })
            end
        }
        '';
}
