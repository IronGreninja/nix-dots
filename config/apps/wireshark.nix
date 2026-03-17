{
  self,
  lib,
  ...
}: {
  ig.apps._.wireshark = {user, ...}: {
    description = "Requires-Groups: wireshark";
    nixos = {pkgs, ...}: {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
        dumpcap.enable = true;
      };
      users.users.${user.userName}.extraGroups = ["wireshark"];
    };
  };
}
