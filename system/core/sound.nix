## Expose custom option to enable sound with pipewire
{
  lib,
  config,
  ...
}: let
  cfg = config.systemModules.core.sound;
in {
  options.systemModules.core.sound = {
    enable = lib.mkEnableOption "Enable sound with pipewire";
  };
  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };
  };
}
