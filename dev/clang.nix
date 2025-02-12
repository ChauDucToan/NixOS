{ pkgs ? import <nixpkgs> {}, user, ...}@inputs:
pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
        clang-tools
        clang
        cmake
        # (import ("${builtins.toString user.location.config}/packages/gmp.nix") {inherit pkgs;})
        gmp
    ];
    
    BuildInputs = [
    ];

    shellHook = ''
        cd ~/Desktop/C/
        PATH="${pkgs.clang-tools}/bin:$PATH"
        ln -sf "${pkgs.clang}/bin/clangd" "/home/oslamelon/.local/share/nvim/mason/bin/clangd"
        ${pkgs.fortune}/bin/fortune | ${pkgs.cowsay}/bin/cowsay
    '';
}
