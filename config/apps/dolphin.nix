{inputs, ...}: {
  ig.apps._.dolphin._.outside-kde.nixos = {pkgs, ...}: {
    # https://wiki.nixos.org/wiki/Dolphin#Open_with_menu_fix
    nixpkgs.overlays = [inputs.dolphin-overlay.overlays.default];

    environment.systemPackages = with pkgs; [
      kdePackages.dolphin

      kdePackages.kdegraphics-thumbnailers
      kdePackages.qtsvg

      kdePackages.gwenview
      kdePackages.okular
      kdePackages.ark

      # https://discourse.nixos.org/t/dolphin-cannot-mount-external-encrypted-hard-drive/38943
      kdePackages.plasma-workspace
      kdePackages.kded
    ];

    services.udisks2.enable = true;
  };
}
# other solutions:
# https://www.reddit.com/r/niri/comments/1qcm5cd/not_really_a_guide_to_setup_dolphin_kde_file/

