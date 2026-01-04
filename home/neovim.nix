{inputs, ...}: {
  imports = [inputs.nixCats.homeModules.default];

  homeSettings.nvim = {
    enable = true;
    packageNames = ["nvim"]; # "nvim-test"];
  };
  home.sessionVariables.EDITOR = "nvim";
}
