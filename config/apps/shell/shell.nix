{
  ig.shell.homeManager = {
    config,
    pkgs,
    ...
  }: {
    home.shellAliases = {
      hm = "home-manager";
      v = "nvim";
      # cat = "bat";
      man = "batman";

      S = "systemctl";
      Su = "S --user";
      J = "journalctl";
      Ju = "J --user";
    };

    programs = {
      bash = {
        enable = true;
        historyFile = "${config.xdg.dataHome}/bash/history";
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      zoxide.enable = true;

      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [batman];
        config = {
          # theme = "TwoDark";
        };
      };

      eza = {
        enable = true;
        git = true;
        icons = "auto";
        extraOptions = ["--octal-permissions"];
      };

      fzf.enable = true;

      fastfetch.enable = true;
    };
    xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch.jsonc;
  };
}
