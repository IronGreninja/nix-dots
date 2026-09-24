{inputs, ...}: {
  ig.apps._.browser._.zen.homeManager = {pkgs, ...}: {
    imports = [inputs.zen-browser.homeModules.beta];
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
      enablePrivateDesktopEntry = true;

      profiles.default = {};
    };
  };
}
