{getSystem, ...}: {
  ig.display-manager._.sddm.nixos = {pkgs, ...}: let
    theme = (getSystem pkgs.stdenv.hostPlatform.system).packages.sddm-astronaut-theme.override {
      themeName = "hyprland_kath";
      themeConfig.FontSize = 16;
    };
  in {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      # theme = "breeze";
      extraPackages = [theme];
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

    environment.systemPackages = [theme];
  };

  ig.display-manager._.ly.nixos = {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        vi_mode = true;
        vi_default_mode = "insert";
        numlock = true;
      };
    };
  };
}
