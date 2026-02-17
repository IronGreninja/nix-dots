{...}: {
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
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
  };
}
