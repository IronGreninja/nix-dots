{inputs, ...}: {
  ig.apps._.dolphin._.outside-kde.nixos = {pkgs, ...}: {
    # https://wiki.nixos.org/wiki/Dolphin#Open_with_menu_fix
    environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    environment.systemPackages = with pkgs; [
      kdePackages.dolphin

      # icons & file-previews
      kdePackages.qtsvg
      kdePackages.kdegraphics-thumbnailers
      kdePackages.kimageformats
      kdePackages.qtimageformats

      kdePackages.gwenview
      kdePackages.okular
      kdePackages.ark

      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-extras

      # https://discourse.nixos.org/t/dolphin-cannot-mount-external-encrypted-hard-drive/38943
      # fixme: why download this just to use a file manager :(
      kdePackages.plasma-workspace
      kdePackages.kded
    ];

    # services.udisks2.enable = true; # query/mount storage devices
    services.gvfs.enable = true; # mount android(mtp), also enables udisks2
  };
  # for working rightclick -> "open terminal here" / "open with nvim"
  # https://github.com/wezterm/wezterm/issues/2103
  # https://discuss.kde.org/t/dolphin-setup-default-open-terminal-here-outside-of-plasma/49305/2
  # home.file.".config/kdeglobals".text = ''
  #   [General]
  #   TerminalService=org.wezfurlong.wezterm.desktop
  #   TerminalApplication=wezterm
  # '';
  # TerminalService fixes "open terminal here"
  # TerminalApplication fixes "open with nvim"
}
# another guide:
# https://www.reddit.com/r/niri/comments/1qcm5cd/not_really_a_guide_to_setup_dolphin_kde_file/

