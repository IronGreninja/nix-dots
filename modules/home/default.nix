{...}: {
  flake.modules.homeManager.default = {config, ...}: {
    xdg.enable = true; # creates the $XDG_*_* env variables and sets xdg.configFile.*
    xdg.userDirs = {
      # for $XDG_*_DIR
      enable = true;
      # createDirectories = true;
    };

    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/nix-dots";
    };

    ## Environment Variables ##
    home.sessionVariables = {
    };

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    # remove warning when starting virt-manager for the first time
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    programs.home-manager.enable = true; # Let Home Manager install and manage itself.

    #https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
