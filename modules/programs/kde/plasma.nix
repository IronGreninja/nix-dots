{self, ...}: {
  flake.modules.nixos.kdeplasma = {...}: {
    imports = with self.modules.nixos; [
      sddm
    ];
    services.xserver.enable = false;
    services.desktopManager.plasma6.enable = true;
    programs.kdeconnect.enable = true;
  };
}
