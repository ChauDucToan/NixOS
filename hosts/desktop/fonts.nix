{pkgs, inputs, ...}: {
    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [ 
            # noto-fonts
            # noto-fonts-cjk-serif
            # noto-fonts-cjk-sans
            nerd-fonts.noto
            nerd-fonts.symbols-only
        ];

    };

}
