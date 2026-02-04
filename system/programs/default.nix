## Programs & Services
{
  imports = [
    ./samba.nix
    ./ssh.nix
    ./thunar.nix
    ./hyprlock-pam.nix
  ];

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
  };
}
