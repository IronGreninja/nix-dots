{__findFile, ...}: {
  ig.podman._.jellyfin = {
    includes = [<ig/podman>];
    homeManager.services.podman = {
      containers.jellyfin-server = {
        image = "docker.io/jellyfin/jellyfin:latest";
        autoUpdate = "registry";
        ports = ["8096:8096/tcp" "7359:7359/udp"];
        userNS = "keep-id";
        volumes = [
          "jellyfin-config:/config"
          "jellyfin-cache:/cache"
          "%h/Videos/media:/media:ro"
        ];
        extraConfig.Service.SuccessExitStatus = "0 143";
        autoStart = false;
      };
      volumes.jellyfin-config = {};
      volumes.jellyfin-cache = {};
    };

    _.openFirewall = {
      includes = [<ig/podman/jellyfin>];
      nixos.networking.firewall = {
        allowedTCPPorts = [8096];
        allowedUDPPorts = [7359];
      };
    };
  };
}
