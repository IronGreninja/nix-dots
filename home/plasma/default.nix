{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];

  programs.plasma = {
    # overrideConfig = true;

    fonts = let
      forAllApplyTo = lib.genAttrs ["general" "small" "toolbar" "menu" "windowTitle"];
    in
      forAllApplyTo (applyTo: {
        family = "Noto Sans";
        pointSize = 14;
      })
      // {
        fixedWidth = {
          family = "Hack";
          pointSize = 14;
        };
      };

    workspace = {
      cursor = {
        size = 48;
        theme = "Breeze_Light";
      };
      clickItemTo = "select";
      colorScheme = "BreezeDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      theme = "breeze-dark";
      iconTheme = "Breeze Dark";
    };
  };
}
