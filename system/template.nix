## Example template for custom modules
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.customModules."category"."name";
in {
  options = {
    customModules."category"."name".enable =
      lib.mkEnableOption "enables name";
  };
  config = lib.mkIf cfg.enable {
    option1.enable = true;

    environment.systemPackages = with pkgs; [hello];
  };
}
