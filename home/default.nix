{
  outputs,
  username,
  host,
  flakeDir,
  ...
}: {
  imports = [
    ./git.nix #
    ./kitty.nix #
    ./fonts #
    ./cli
    ./vscopium #
    ./waybar #
    # ./zathura.nix
    ./hyprland #
    # ./mako.nix
    # ./gtk-qt.nix
    ./browsers
    ./anyrun #
    ./nixvim.nix
    ./stylua.nix
    ./ssh.nix
    ./stylix.nix

    ../hosts/${host}/home.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  xdg.enable = true; # creates the $XDG_*_* env variables and sets xdg.configFile.*
  xdg.userDirs = {
    # for $XDG_*_DIR
    enable = true;
    createDirectories = true;
  };

  ## Environment Variables ##
  home.sessionVariables = {
    NH_FLAKE = flakeDir;
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
}
