{inputs, ...}: {
  ig.apps._.editor._.neovim.homeManager = {pkgs, ...}: {
    home.packages = with inputs.nvim-config.packages.${pkgs.stdenv.hostPlatform.system}; [
      default
      test
    ];
    home.sessionVariables.EDITOR = "nvim";
  };
}
