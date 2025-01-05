{ inputs, config, username, pkgs, ... }:

{
  imports = [
    ./osu.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.05"; 

  home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
  };

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # waybar
    # hyprland
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')

    (writeShellScriptBin "my-md-template" (
      builtins.readFile ../conf/Bin/makeTemplatesmd.bash)
    )
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    "/home/${username}/.config/nvim/init.lua".source = ../conf/nvim/init.lua;
    "/home/${username}/.config/nvim/lua".source = ../conf/nvim/lua;
    # "/home/${username}/.config/nvim".source = ../conf/nvim;
    "/home/${username}/.config/waybar".source = ../conf/waybar;
    "/home/${username}/.config/kitty".source = ../conf/kitty;
    "/home/${username}/.config/hypr".source = ../conf/hypr;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-with-addons ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/oslamelon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE= "fcitx";
    GLFW_IM_MODULE="ibus";
    XMODIFIERS = "@im=fcitx";
  };

  # systemd.user.enable = true;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
