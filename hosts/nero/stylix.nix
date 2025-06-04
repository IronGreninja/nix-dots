{
  hostOptions,
  inputs,
  pkgs,
  config,
  ...
}: let
  opts = hostOptions;
in {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${opts.theme}.yaml";
    image = config.lib.stylix.pixel "base0A";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = config.stylix.fonts.sansSerif;

      sizes = {
        terminal = 18;
        applications = 15;
        desktop = 15;
        popups = 15;
      };
    };
    cursor = {
      package = pkgs.kdePackages.breeze;
      name = "Breeze_Light";
      size = 48;
    };
  };
  stylix.targets = {
    kitty.enable = true;
    vscode = {
      enable = true;
      profileNames = ["default"];
    };
    lazygit.enable = true;
    # neovim.enable = true;
  };
}
