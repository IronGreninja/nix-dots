{
  ig.wm._.niri.homeManager = {pkgs, ...}: {
    systemd.user.services.niri-wants-polkit = {
      Unit = {
        Description = "KDE Polkit for niri";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        BusName = "org.kde.polkit-kde-authentication-agent-1";
        Slice = "background.slice";
        TimeoutStopSec = "5sec";
        Restart = "on-failure";
      };
      Install.WantedBy = ["niri.service"];
    };
  };
}
