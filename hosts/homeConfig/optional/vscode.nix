{pkgs, ...}: {
    programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;
        package = pkgs.vscode-fhs;

        profiles.default = {
            extensions = with pkgs.vscode-extensions; [
                sainnhe.gruvbox-material
                vscodevim.vim
                yzhang.markdown-all-in-one
            ] ++ [
                llvm-vs-code-extensions.vscode-clangd
                ms-vscode.cpptools-extension-pack
                ms-vscode.cmake-tools
            ];
        };
    };
}
