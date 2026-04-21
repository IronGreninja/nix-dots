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

          # https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font
          symbol_map U+e000-U+e00a,U+e0a0-U+e0a2,U+e0a3,U+e0b0-U+e0b3,U+e0b4-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ea60-U+ec1e,U+ed00-U+efce,U+f000-U+f2ff,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono

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
