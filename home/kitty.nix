{lib, ...}: let
  fontname = "family='JetBrainsMono Nerd Font' variable_name=JetBrainsMono";
  features = "features='+ss02 +zero'";
in {
  programs.kitty = {
    font.name = lib.mkForce "${fontname} style=ExtraLight ${features}";
    # shellIntegration.mode = "no-title"; # https://www.reddit.com/r/KittyTerminal/comments/1d1u05r/delay_setting_tab_title_instead_of_on_every/
    settings = {
      # confirm_os_window_close = 0;
    };
    extraConfig = lib.mkAfter ''
      #### After stylix

      bold_font ${fontname} style=Medium ${features}
      italic_font ${fontname} style='ExtraLight Italic' ${features}
      bold_italic_font ${fontname} style='Medium Italic' ${features}

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
}
