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
        cursorTheme = {
          name = "Breeze_snow"; # see https://wiki.archlinux.org/title/SDDM#Mouse_cursor
          size = 48;
        };
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

      # outputs.packages.${pkgs.system}.sddm-astronaut-theme
      # vergilDark
      # (pkgs.where-is-my-sddm-theme.override {
      #   themeConfig.General = {
      #     showSessionsByDefault = "true";
      #   };
      # })
    ];
  }
