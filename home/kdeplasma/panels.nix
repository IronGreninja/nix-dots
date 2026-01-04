{
  programs.plasma.panels = [
    {
      location = "bottom";
      alignment = "center";
      lengthMode = "fill";
      floating = true;
      height = 48;
      hiding = "normalpanel";
      widgets = [
        {
          kickoff = {
            icon = "nix-snowflake-white";
          };
        }
        {
          iconTasks = {
            appearance.iconSpacing = "large";
            launchers = [
              "applications:systemsettings.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"
            ];
          };
        }

        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.colorpicker"
        "org.kde.plasma.marginsseparator"

        {
          systemTray = {};
        }
        {
          digitalClock = {};
        }
        "org.kde.plasma.showdesktop"
      ];
    }
  ];
}
