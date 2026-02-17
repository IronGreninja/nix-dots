{
  self,
  lib,
  ...
}: {
  ig.apps._.wireshark = {
    description = "Requires-Groups: wireshark";
    nixos = {pkgs, ...}: {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
        dumpcap.enable = true;
      };
    };
  };
}
