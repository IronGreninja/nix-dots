{
  ig.wm._.niri = {
    nixos.programs.kdeconnect.enable = true;
    homeManager = {pkgs, ...}: {
      systemd.user.services.niri-wants-kdeconnect = {
        Unit = {
          Description = "kdeconnect for niri";
          After = "niri.service";
        };
        Service = {
          ExecStart = "${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator"; # starts kdeconnectd + tray icon
          Restart = "on-failure";
        };
        Install.WantedBy = ["niri.service"];
      };
    };
  };
}
