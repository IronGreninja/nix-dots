{pkgs, ...}: let
in {
  home.packages = with pkgs; [
    pkgs.waybar
    pulseaudio # gives pactl command
    pavucontrol
    # networkmanagerapplet # nm-connection-editor
  ];

  programs.waybar = {
    style = ./style.css;
  };

  xdg.configFile."waybar/config".source = ./config;
}
