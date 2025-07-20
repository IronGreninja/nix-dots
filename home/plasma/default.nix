{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];

  programs.plasma = {
    # overrideConfig = true;

    fonts = let
      # forAllApplyTo = lib.genAttrs ["general" "small" "toolbar" "menu" "windowTitle"];
      forAllApplyTo = lib.genAttrs ["general" "fixedWidth" "small" "toolbar" "menu" "windowTitle"];
      all = forAllApplyTo (applyTo: {
        family = "Noto Sans";
        pointSize = 16;
      });
    in
      lib.recursiveUpdate all {
        fixedWidth = {family = "Hack";};
        small = {pointSize = 14;};
      };
    # forAllApplyTo (applyTo: {
    #   family = "Noto Sans";
    #   pointSize = 16;
    # })
    # // {
    #   fixedWidth = {
    #     family = "Hack";
    #     pointSize = 16;
    #   };
    # };

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
