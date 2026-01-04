{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    # (lutris.override {
    #   extraLibraries = pkgs: [
    #     pkgs.curlWithGnuTls
    #   ];
    #   extraPkgs = pkgs: [
    #     pkgs.curlWithGnuTls
    #   ];
    # })

    mangohud
    goverlay
    protonup-qt
    wineWowPackages.stable
    winetricks
    # xorg.xrdb # for steam
    # xsettingsd

    # prismlauncher
  ];
}
