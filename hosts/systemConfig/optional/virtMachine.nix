{user, pkgs, ...}: {
    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ user.info.username ];

    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            ovmf.packages = [ pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd ];
        };
    };

    virtualisation.spiceUSBRedirection.enable = true;

    users.users."${user.info.username}".extraGroups = [ "libvirtd" ];
}
