# whether to enable virtual cam support for e.g. in obs-studio
{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.customModules.programs.obs.virtualCam;
in {
  options.customModules.programs.obs.virtualCam = {
    enable = mkEnableOption "Enable virtual cam support for obs";
  };

  config = mkIf cfg.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;
  };
}
