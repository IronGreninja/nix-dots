{
  __findFile,
  lib,
  den,
  ...
}: {
  den.ctx.user.includes = [<den/mutual-provider>];

  den.default = {
    includes = [
      <den/define-user>
      <den/hostname>
      den.provides.inputs'
      den.provides.self'
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
      hardware.enableRedistributableFirmware = true;
      hardware.cpu.intel.updateMicrocode = true;
    };

    homeManager = {
      systemd.user.startServices = "sd-switch";
      home = {
        sessionPath = ["$HOME/.local/bin"];
        # sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
        stateVersion = "23.11";
      };
      xdg.enable = true;
      # xdg.userDirs.enable = true;
    };
  };
}
