{pkgs, lib, user,...}: {
    imports = [
        ./colors.nix
        ./init.nix
        ./lsp.nix
        ./telescope.nix
        ./treesitter.nix
        ./lualine.nix
        ./markview.nix
    ];
}
