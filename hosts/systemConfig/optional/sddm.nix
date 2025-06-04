{
    pkgs, lib,

    themeName? null,
    themePackage? null,
    isWayland? false,
    dependencies? []
}:
{
    config = lib.mkMerge [
        (lib.mkIf (themeName != null)  {
            services.displayManager.sddm = {
                enable = true;
                package = pkgs.kdePackages.sddm;

                theme = (builtins.replaceStrings ["-"] ["_"] "${themeName}");

                extraPackages = dependencies;

                wayland.enable = isWayland;
            };
        })

        (lib.mkIf (themePackage != null) {
            environment.systemPackages = [
                themePackage
            ];
        })
    ];
}
