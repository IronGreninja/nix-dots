{
  flake.modules.homeManager.zathura = {...}: let
  in {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
    };
  };
}
