## Set default sddm theme
{
  config,
  pkgs,
  lib,
  outputs,
  ...
}: let
in
  lib.mkIf config.services.displayManager.sddm.enable {
    services.displayManager.sddm = {
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
      (outputs.packages.${pkgs.system}.sddm-astronaut-theme.override {
        themeName = "jake_the_dog";
        themeConfig.General.FontSize = 20;
      })
    ];
  }
