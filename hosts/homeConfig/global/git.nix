{ pkgs, user, ... }: {
    programs.git = {
        enable = true;
        userName = "${user.info.username}";
        userEmail = "91736051+ChauDucToan@users.noreply.github.com";
    };
}
