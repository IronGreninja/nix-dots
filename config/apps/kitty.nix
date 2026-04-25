{ig, ...}: {
  ig.apps._.kitty = {
    includes = [ig.fonts];

    homeManager = {lib, ...}: {
      programs.kitty = let
        ffam = "family='JetBrains Mono'";
        ffeat = "features='+zero +ss02'";
      in {
        enable = true;
        # shellIntegration.mode = "no-title"; # https://www.reddit.com/r/KittyTerminal/comments/1d1u05r/delay_setting_tab_title_instead_of_on_every/
        settings = {
          # confirm_os_window_close = 0;
        };
        keybindings = {
          "ctrl+shift+t" = "new_tab_with_cwd";
        };
        extraConfig = lib.mkAfter ''
          #### After stylix

          font_family      ${ffam} style=JetBrainsMono-ExtraLight variable_name=JetBrainsMono ${ffeat}
          bold_font        ${ffam} variable_name=JetBrainsMono style=JetBrainsMono-Medium ${ffeat}
          italic_font      ${ffam} style=JetBrainsMono-ExtraLightItalic variable_name=JetBrainsMonoItalic ${ffeat}
          bold_italic_font ${ffam} style=JetBrainsMono-MediumItalic variable_name=JetBrainsMonoItalic ${ffeat}

          cursor none
          cursor_trail 3

          tab_bar_edge top
          tab_bar_margin_height 2 2
          tab_bar_style fade
          tab_powerline_style slanted
          tab_title_template "{sup.index} {title}"
          active_tab_foreground #89b482
        '';
      };
    };
  };
}
