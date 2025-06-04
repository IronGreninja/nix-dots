{
  pkgs,
  config,
  lib,
  hostOptions,
  username,
  ...
}: let
in {
  programs.firefox = {
    # policies = {
    #   DisablePocket = true;
    #   DisableTelemetry = true;
    #   DontCheckDefaultBrowser = true;
    # };

    profiles."${username}" = {
      extraConfig = let
        betterfox-user_js = builtins.readFile (pkgs.fetchFromGitHub {
            owner = "yokoffing";
            repo = "Betterfox";
            rev = "c36643914571d10b45f863e3916441071b838ae3";
            hash = "sha256-eHocB5vC6Zjz7vsvGOTGazuaUybqigODEIJV9K/h134=";
          }
          + "/user.js");

        betterfoxOverrides =
          /*
          js
          */
          ''
            // visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
            user_pref("signon.rememberSignons", false);
            user_pref("extensions.formautofill.addresses.enabled", false);
            user_pref("extensions.formautofill.creditCards.enabled", false);
            user_pref("dom.security.https_only_mode", true);
            user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);
            // visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
            user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
            user_pref("general.smoothScroll", true); // DEFAULT
            user_pref("mousewheel.default.delta_multiplier_y", 70); // 250-400; adjust this number to your liking
          '';
      in
        betterfox-user_js + betterfoxOverrides;

      search.force = true;
      search.engines = {
        "Nix Packages" = {
          urls = [{template = "https://search.nixos.org/packages?channel=24.05&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
          iconUpdateURL = "https://nixos.org/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
          definedAliases = ["@np"];
        };
        "Nix Options" = {
          urls = [{template = "https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";}];
          iconUpdateURL = "https://nixos.org/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
          definedAliases = ["@no"];
        };
        "HomeManager Options" = {
          urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.05";}];
          iconUpdateURL = "https://nixos.org/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000;
          definedAliases = ["@ho"];
        };
      };
    };
  };
}
