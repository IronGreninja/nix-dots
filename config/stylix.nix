{inputs, ...}: {
  ig.stylix = let
    theme = "horizon-dark";
  in {
    nixos = {
      pkgs,
      config,
      ...
    }: {
      imports = [inputs.stylix.nixosModules.stylix];

      stylix = {
        enable = true;
        autoEnable = false;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
        polarity = "dark";
        # image = config.lib.stylix.pixel "base0A"; # use base16Scheme

        fonts = {
          monospace = {
            # package = pkgs.nerd-fonts.jetbrains-mono;
            # name = "JetBrainsMono Nerd Font";
            package = pkgs.jetbrains-mono;
            name = "JetBrains Mono";
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

        targets = {};
      };
    };

    homeManager.stylix.targets = {
      bat.enable = true;
      fzf.enable = true;
      kitty = {
        enable = true;
        # variant256Colors = false;
      };
    };
  };
}
