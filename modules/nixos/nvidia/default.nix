{
  config,
  lib,
  ...
}: let
  cfg = config.systemSettings.nvidia;
  pCfg = cfg.prime;
in
  with lib; {
    options.systemSettings.nvidia = {
      enable = mkEnableOption "Install nvidia drivers and set default prime mode (for hybrid laptops)";
      prime = {
        enable = mkEnableOption "Enable prime for hybrid laptops. Setting bus Id's is required";
        defaultMode = mkOption {
          type = types.enum ["offload" "sync"];
          default = "offload";
          description = "Set default prime mode. The other will be available as a specialization";
        };
        intelBusId = mkOption {
          type = types.str;
          default = "";
        };
        nvidiaBusId = mkOption {
          type = types.str;
          default = "";
        };
      };
    };

    config = let
      secMode =
        if pCfg.defaultMode == "offload"
        then "sync"
        else "offload";
    in
      mkMerge [
        (mkIf cfg.enable {
          hardware.graphics = {
            enable = true;
            enable32Bit = true;
          };
          services.xserver.videoDrivers = ["nvidia"];
          hardware.nvidia = {
            open = false;
            modesetting.enable = true;
            nvidiaSettings = true;
          };
        })

        (mkIf pCfg.enable {
          hardware.nvidia.prime = {
            inherit (pCfg) intelBusId nvidiaBusId;
          };
          hardware.nvidia.prime.${pCfg.defaultMode} =
            {
              enable = true;
            }
            // (
              if secMode == "sync"
              then {enableOffloadCmd = true;}
              else {}
            );
          specialisation.${secMode}.configuration.hardware.nvidia.prime =
            {
              ${pCfg.defaultMode}.enable = mkForce false;
              ${secMode}.enable = mkForce true;
            }
            // (
              if secMode == "offload"
              then {offload.enableOffloadCmd = mkForce false;}
              else {}
            );
        })
      ];
  }
