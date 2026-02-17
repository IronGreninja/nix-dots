{
  flake.modules.homeManager.waybar = {pkgs, ...}: {
    home.packages = with pkgs; [
      pulseaudio # gives pactl command
      pavucontrol
      # networkmanagerapplet # nm-connection-editor
    ];
  };
}
