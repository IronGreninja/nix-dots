## Expose custom option to install nvidia drivers
{
  config,
  lib,
  ...
}: let
  cfg = config.customModules.hardware.nvidia;
  pCfg = cfg.prime;
in {
  options.customModules.hardware.nvidia = {
    enable = lib.mkEnableOption "Install nvidia drivers";
    prime.enable = lib.mkEnableOption ''
      Enable prime for dual gpu laptops
      Default mode: sync
      Specialisation: offload-mode (available as a grub entry)

      NOTE: intelBusId & nvidiaBudId must be set separately in the hosts' hardware-configuration";
    '';
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
      };
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        open = false;
      };
    })

    (lib.mkIf pCfg.enable {
      # set the busId & prime/sync mode in the hosts' hardware-configuration.nix
      hardware.nvidia.prime.sync.enable = true;

      specialisation.offload-mode.configuration = {
        hardware.nvidia.prime = {
          sync.enable = lib.mkForce false;
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
        };
      };
    })
  ];
}
