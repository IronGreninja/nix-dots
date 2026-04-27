{
  ig.wm._.niri = {
    nixos.programs.kdeconnect.enable = true;
    homeManager = {pkgs, ...}: {
      systemd.user.services.niri-wants-kdeconnectd = {
        Unit = {
          Description = "kdeconnect for niri";
          After = "niri.service";
        };
        Service = {
          ExecStart = "${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnectd";
          Restart = "on-failure";
        };
        Install.WantedBy = ["niri.service"];
      };
    };
  };
}
