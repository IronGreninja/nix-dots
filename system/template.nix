## Example template for custom system modules
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.systemModules."category"."name";
in {
  options = {
    systemModules."category"."name".enable =
      lib.mkEnableOption "enables name";
  };
  config = lib.mkIf cfg.enable {
    option1.enable = true;

    environment.systemPackages = with pkgs; [hello];
  };
}
