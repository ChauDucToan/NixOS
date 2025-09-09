{ pkgs, user, ...}: {
    environment.systemPackages = with pkgs; [
        nautilus
    ];

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    users.users.${user.info.username} = {
        extraGroups = [ "storage" ];
    };
}
