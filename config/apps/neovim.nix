{
  ig.apps._.editor._.neovim.homeManager = {
    lib,
    config,
    inputs',
    ...
  }: let
    stylixColors = config.lib.stylix.colors.withHashtag or null;
    palette =
      if stylixColors != null
      then
        lib.filterAttrs (
          k: v: builtins.match "base0[0-9A-F]" k != null
        )
        stylixColors
      else null;
    opts = {settings.base16palette = palette;};
  in {
    home.packages = with inputs'.nvim-config.packages; [
      (default.wrap opts)
      (test.wrap opts)
    ];
    home.sessionVariables.EDITOR = "nvim";
  };
}
