{user, ...}: {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ user.info.username ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

    users.users."${user.info.username}".extraGroups = [ "libvirtd" ];
}
