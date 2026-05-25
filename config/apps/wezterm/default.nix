{
  ig.apps._.wezterm = {
    homeManager = {
      programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./wezterm.lua;
      };
      # https://docs.vicinae.com/faq#how-to-set-which-terminal-to-use-to-launch-terminal-apps
      xdg.configFile."xdg-terminals.list".text = "org.wezfurlong.wezterm.desktop";
    };
  };
}
