{user, ...}: {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ user.info.username ];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    users.users."${user.info.username}".extraGroups = [ "libvirtd" ];
}
