{
  pkgs,
  lib,
  config,
  inputs,
  hostOptions,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
  o = hostOptions;
in
  lib.mkIf ((o.hyprland or false) && !(o.kdeplasma or false)) {
    # Cursor theme
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 48;
    };

    # gtk and qt theme
    gtk = {
      enable = true;
      theme = {
        package = gtkThemeFromScheme {scheme = config.colorScheme;};
        name = "${config.colorScheme.slug}";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };

      font = {
        name = "CaskaydiaCove Nerd Font";
        size = 16;
      };

      gtk3.extraConfig.gtk-decoration-layout = "menu:";
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "adwaita-dark";
      style.package = pkgs.adwaita-qt;
    };
  }
