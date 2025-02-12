{
    imports = [
        ../../../modules/homeManagerModules/neovim
    ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };
}
