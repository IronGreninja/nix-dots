{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    {
      nixos.wireshark = {pkgs, ...}: {
        programs.wireshark = {
          enable = true;
          package = pkgs.wireshark;
          dumpcap.enable = true;
        };
      };
    }

    (self.factory.groupsToUsers ["wireshark"]
      ["igreninja"])
  ];
}
