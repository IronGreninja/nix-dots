{
  inputs,
  getSystem,
  __findFile,
  flakeDir,
  ...
}: {
  ig.wm._.niri = {
    includes = [
      <ig/display-manager/ly>
      <ig/apps/wezterm>
      <ig/apps/dolphin/outside-kde>
    ];

    nixos = {pkgs, ...}: {
      programs.niri.enable = true;
      environment.systemPackages = [pkgs.xwayland-satellite];
    };

    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.packages = with pkgs; [
        noctalia-shell

        cliphist
        wl-clipboard

        (getSystem pkgs.stdenv.hostPlatform.system).packages.qt6ct-kde
        adw-gtk3
        nwg-look
        # sunsetr # night-light

        seahorse
      ];

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
          kdePackages.xdg-desktop-portal-kde
        ];
        config.niri = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          "org.freedesktop.impl.portal.FileChooser" = "kde";
        };
      };

      home.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      # or use xdg.configFile."environment.d/niri.conf".text = ...

      xdg.configFile.niri = {
        source = config.lib.file.mkOutOfStoreSymlink "${flakeDir}/config/niri/config";
        # source = ./config;
        recursive = true;
      };
    };
  };
}
