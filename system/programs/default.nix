{
  imports = [
    ./thunar.nix
    ./virtualisation.nix
    ./obsVirtualCam.nix
    ./nh.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
  };
}
