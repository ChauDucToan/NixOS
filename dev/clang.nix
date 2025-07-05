{ pkgs ? import <nixpkgs> {}, user, ...}@inputs:
pkgs.mkShell {
    name = "c/c++-env";
    nativeBuildInputs = with pkgs; [
        clang-tools
        clang
        cmake
        # (import ("${builtins.toString user.location.config}/packages/gmp.nix") {inherit pkgs;})

        SDL2
        SDL2_ttf
        SDL2_mixer

        pkg-config
        cmake
    ];
    
    BuildInputs = [
    ];

    shellHook = ''
        export NIX_CFLAGS_COMPILE="$(pkg-config --cflags sdl2 SDL2_ttf SDL2_mixer)"
        export NIX_LDFLAGS="$(pkg-config --libs sdl2 SDL2_ttf SDL2_mixer)"

        PATH="${pkgs.clang-tools}/bin:$PATH"
        ln -sf "${pkgs.clang}/bin/clangd" "/home/oslamelon/.local/share/nvim/mason/bin/clangd"
        ${pkgs.fortune}/bin/fortune | ${pkgs.cowsay}/bin/cowsay
    '';
}
