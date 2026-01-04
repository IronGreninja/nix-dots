{
  services.hyprsunset = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = {
      profile = [
        {
          time = "6:00";
          temperature = 4500;
        }
        {
          time = "18:00";
          temperature = 3900;
          # gamma = 0.8;
        }
      ];
    };
  };
}
