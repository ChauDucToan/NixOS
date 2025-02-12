{pkgs, ...}: {
    # Enable CUPS to print documents.
    services.printing = {
        enable = true;
        drivers = with pkgs; [
            hplipWithPlugin
            hplip
        ];
    };
}
