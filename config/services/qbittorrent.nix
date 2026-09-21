{
  ig.qbittorrent-nox.homeManager = {pkgs, ...}: {
    systemd.user.services.qbittorrent-nox = {
      Unit = {
        Description = "qBittorrent Headless Client";
        Wants = ["network-online.target"];
        After = [
          "local-fs.target"
          "network-online.target"
          "nss-lookup.target"
        ];
      };

      Service = {
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    home.file.".local/share/qBittorrent/vuetorrent".source = "${pkgs.vuetorrent}/share/vuetorrent";
  };
}
