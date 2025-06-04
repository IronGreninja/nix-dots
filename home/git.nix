{
  config,
  pkgs,
  lib,
  ...
}: let
in {
  programs.git = {
    enable = true;
    userName = "IronGreninja";
    userEmail = "92992745+IronGreninja@users.noreply.github.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      color.ui = "auto";
      pull.rebase = "false";

      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = "true";
        dark = "true";
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
    aliases = {
      a = "add";
      b = "branch";
      c = "commit -v";
      ca = "commit -v --amend";
      cm = "commit -m";
      co = "checkout";
      d = "diff";
      ds = "diff --staged";
      p = "push";
      pf = "push --force-with-lease";
      pl = "pull";
      l = "log";
      r = "rebase";
      s = "status --short";
      ss = "status";
      forgor = "commit --amend --no-edit";
      graph = "log --all --decorate --graph --oneline";
      # oops = "checkout --";
    };
    ignores = [
      ".direnv"
      "result"
    ];
  };
  home.packages = with pkgs; [delta];
  programs.lazygit.enable = true;
}
