{pkgs, inputs, ...}: {
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            ".." = "cd ..";
        };
        initExtra = ''
            __conda_setup="$('/home/oslamelon/.conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
            if [ $? -eq 0 ]; then
                eval "$__conda_setup"
            else
                if [ -f "/home/oslamelon/.conda/etc/profile.d/conda.sh" ]; then
                    . "/home/oslamelon/.conda/etc/profile.d/conda.sh"
                else
                    export PATH="/home/oslamelon/.conda/bin:$PATH"
                fi
            fi
            unset __conda_setup
        '';
    };
}
