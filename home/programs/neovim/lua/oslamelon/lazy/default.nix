{pkgs, lib, username,...}:
{
    imports = [
        ./colors.nix
        ./comment.nix
        ./init.nix
        ./lsp.nix
        ./telescope.nix
        ./treesitter.nix
        ./vimbegood.nix
        ./vimmarkdown.nix
        ./vimtex.nix
        ./lualine.nix
        ./markview.nix
        ./deadcolumn.nix
    ];
}
