{ pkgs ? import <nixpkgs> {}, ...}@inputs:

pkgs.mkShell
{
    nativeBuildInputs = with pkgs; [
        clang-tools
        clang
        cmake
    ];

    shellHook = ''
        cd ~/Desktop/C/
        PATH="${pkgs.clang-tools}/bin:$PATH"
        ln -sf "${pkgs.clang}/bin/clangd" "/home/oslamelon/.local/share/nvim/mason/bin/clangd"
        ${pkgs.fortune}/bin/fortune | ${pkgs.cowsay}/bin/cowsay
    '';
}
