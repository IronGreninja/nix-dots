{
  self,
  __findFile,
  ...
}: {
  ig.de._.plasma = {
    includes = [
      <ig/display-manager/sddm>
    ];
    nixos = {
      services.xserver.enable = false;
      services.desktopManager.plasma6.enable = true;
      programs.kdeconnect.enable = true;
    };
  };
}
