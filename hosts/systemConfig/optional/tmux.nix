{ pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        tmux
    ];

    programs.tmux = {
        enable = true;
        clock24  = true;
        shortcut = "a";
        keyMode = "vi";
    };
}
