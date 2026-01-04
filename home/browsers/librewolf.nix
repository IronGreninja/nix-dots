{pkgs, ...}: {
  programs.librewolf = {
    settings = {
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;

      "widget.use-xdg-desktop-portal.file-picker" = 1; # use kde file-picker
    };
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
  };
}
