{pkgs, inputs, ...}: {

    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [ 
            nerd-fonts.noto
            nerd-fonts.symbols-only
        ];

    };

}
