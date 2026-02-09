## podman containers
{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    {
      nixos.containers = {pkgs, ...}: {
        virtualisation.containers.enable = true;
        virtualisation.podman = {
          enable = true;
          defaultNetwork.settings = {dns_enabled = true;};
        };
      };
    }

    (self.factory.modifiedUsers ["igreninja"]
      {
        extraGroups = ["podman"];
        linger = true;
      })
  ];
}
