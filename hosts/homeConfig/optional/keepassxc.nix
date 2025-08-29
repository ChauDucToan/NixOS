{pkgs, ...}: {
    home.packages = with pkgs; [ keepassxc ];
    programs.bash = {
        initExtra = ''
            # Point SSH at KeePassXC’s agent socket each session
            export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keepassxc-ssh-agent.socket"
        '';
    };
}
