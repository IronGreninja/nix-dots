# whether to enable virtual cam support for e.g. in obs-studio
{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.systemModules.extra.virtualCam;
in {
  options.systemModules.extra.virtualCam = {
    enable = mkEnableOption "Enable virtual cam support through v4l2loopback";
  };

  config = mkIf cfg.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    ## Specify options manually or let the app(e.g. obs) set them when loading the module
    # boot.extraModprobeConfig = ''
    #   options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    # '';
    security.polkit.enable = true;
  };
}
