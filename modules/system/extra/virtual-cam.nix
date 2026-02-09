# virtual cam support with v4l2loopbook for use in e.g. obs-studio
{...}: {
  flake.modules.nixos.virtual-cam = {
    config,
    lib,
    ...
  }: {
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
