{inputs, ...}: {
  ig.apps._.editor._.neovim.homeManager = {
    pkgs,
    lib,
    config,
    ...
  }: let
    palette =
      lib.filterAttrs (
        k: v: builtins.match "base0[0-9A-F]" k != null
      )
      config.lib.stylix.colors.withHashtag;
    opts = {settings.base16palette = palette;};
  in {
    home.packages = with inputs.nvim-config.packages.${pkgs.stdenv.hostPlatform.system}; [
      (default.wrap opts)
      (test.wrap opts)
    ];
    home.sessionVariables.EDITOR = "nvim";
  };
}
