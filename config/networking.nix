{
  ig.networking = {
    nixos = {lib, ...}: {
      networking = {
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
      };
      # Don't wait for network startup
      # systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
    };
  };
}
