{self, ...}: {
  flake.modules.nixos.sddm = {
    config,
    pkgs,
    lib,
    ...
  }: let
  in {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      # theme = "breeze";
      theme = "sddm-astronaut-theme";
      settings = {
        # https://wiki.archlinux.org/title/SDDM#Mouse_cursor # doesn't work
        # FIXME: https://github.com/sddm/sddm/issues/1894
        Theme.CursorTheme = "Breeze_Snow";
        Theme.CursorSize = 48;
        # General.InputMethod = "qtvirtualkeyboard"; # Virtual kbd still doesn't work
      };
      autoNumlock = true;
    };

    environment.systemPackages = let
    in [
      (self.packages.${config.nixpkgs.hostPlatform}.sddm-astronaut-theme.override {
        themeName = "jake_the_dog";
        themeConfig.General.FontSize = 20;
      })
    ];
  };
}
