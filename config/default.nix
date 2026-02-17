{__findFile, ...}: {
  den.default = {
    includes = [
      <den/define-user>
      <den/home-manager>
      (
        {host, ...}: {
          ${host.class}.networking.hostName = host.name;
        }
      )
    ];

    nixos = {
      pkgs,
      lib,
      ...
    }: {
      environment = {
        defaultPackages = lib.mkForce [];
        systemPackages = with pkgs; [man-pages man-pages-posix];
      };
      documentation.doc.enable = false;
      documentation.info.enable = false;
      i18n.defaultLocale = "en_US.UTF-8";
      services.dbus.implementation = "broker";
      system.stateVersion = "23.11";
      time.timeZone = "Asia/Kolkata";
      zramSwap.enable = true;
      hardware.cpu.intel.updateMicrocode = true;
    };

    homeManager = {
      # programs.home-manager.enable = true; # no effect when using hm as nixos module
      systemd.user.startServices = "sd-switch";
      home = {
        sessionPath = ["$HOME/.local/bin"];
        # sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
        stateVersion = "23.11";
      };
      xdg.enable = true;
      xdg.userDirs.enable = true;
    };
  };
}
