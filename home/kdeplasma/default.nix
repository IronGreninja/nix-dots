{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    ./panels.nix
  ];

  programs.plasma = {
    enable = true;
    # overrideConfig = true;

    fonts = let
      forAllApplyTo = lib.genAttrs ["general" "fixedWidth" "small" "toolbar" "menu" "windowTitle"];
      all = forAllApplyTo (applyTo: {
        family = "Noto Sans";
        pointSize = 16;
      });
    in
      lib.recursiveUpdate all {
        fixedWidth = {family = "Hack";};
        small = {pointSize = 14;};
      };

    workspace = {
      cursor = {
        size = 48;
        theme = "Breeze_Light";
      };
      clickItemTo = "select";
      colorScheme = "BreezeDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      theme = "breeze-dark";
      iconTheme = "Breeze Dark";
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerProfile = "performance";
        dimDisplay = {
          enable = true;
          idleTimeout = 300;
        };
        dimKeyboard.enable = true;
        turnOffDisplay = {
          idleTimeout = 600;
          idleTimeoutWhenLocked = 60;
        };
        whenLaptopLidClosed = "turnOffScreen";
      };
    };

    session = {
      general.askForConfirmationOnLogout = true;
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };
    };

    input = {
      mice = [
        {
          acceleration = 1.0;
          accelerationProfile = "none";
          # Use simple defaults instead of probing at build time
          name = "auto";
          vendorId = "0";
          productId = "0";
        }
      ];
    };
  };
}
