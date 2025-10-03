{
  username,
  host,
  hostOptions,
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: let
in {
  imports = [
    # ./system/services/samba.nix
  ];

  services.xserver.enable = false;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  programs.hyprland.enable = true;

  programs.noisetorch.enable = true;
  systemModules = {
    core.sound.enable = true;
    extra.virtualisation.enable = true;
    extra.virtualCam.enable = true;
  };

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings = {dns_enabled = true;};
  };
  users.users.${username} = {
    extraGroups = ["podman"];
    linger = true;
  };

  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  services = {
    nix-serve = {
      enable = true;
      bindAddress = "192.168.29.89";
      openFirewall = true;
    };
  };

  # programs.nix-ld = {
  #   enable = true;
  #   # https://www.reddit.com/r/NixOS/comments/1d1nd9l/walking_through_why_precompiled_hello_world/
  #   libraries = with pkgs; [
  #     openal
  #   ];
  # };
  # networking.firewall.interfaces."wg_asterion".allowedTCPPorts = [9999];
  networking.firewall.allowedTCPPorts = [
    2283 # immich
  ];
}
