## Programs & Services
{
  imports = [
    ./nh.nix
    ./samba.nix
    ./ssh.nix
    ./thunar.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
  };
}
