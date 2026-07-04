{inputs, ...}: {
  ig.apps._.dolphin._.outside-kde.nixos = {pkgs, ...}: {
    # https://wiki.nixos.org/wiki/Dolphin#Open_with_menu_fix
    nixpkgs.overlays = [inputs.dolphin-overlay.overlays.default];

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

      # fixme: this should allow mounting android w/ mtp. but doesn't work. alternative: manual mounting w/ jmtpfs. (see wiki.nixos on MTP)
      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-extras

      # https://discourse.nixos.org/t/dolphin-cannot-mount-external-encrypted-hard-drive/38943
      # fixme: why download this just to use a file manager :(
      kdePackages.plasma-workspace
      kdePackages.kded
    ];

    services.udisks2.enable = true;
  };
  # for working rightclick -> "open terminal here" / "open with nvim"
  # home.file.".config/kdeglobals".text = ''
  #   [General]
  #   TerminalApplication=wezterm
  # '';
}
# another guide:
# https://www.reddit.com/r/niri/comments/1qcm5cd/not_really_a_guide_to_setup_dolphin_kde_file/

