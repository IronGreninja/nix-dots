{
  pkgs,
  config,
  inputs,
  flakeDir,
  username,
  host,
  lib,
  ...
}: let
  ext = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
  ov = ext.open-vsx;
  # vm = ext.vscode-marketplace;
  vscDir = "${flakeDir}/home/vscopium";
in {
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium.fhsWithPackages (ps: with ps; []);
    package = pkgs.vscodium;

    profiles.default.extensions = [
      # Look n Feel
      ov.pkief.material-product-icons
      ov.sainnhe.gruvbox-material

      # Language support
      ov.ms-python.python
      ov.ms-python.black-formatter
      ov.ms-python.debugpy
      ov.ms-pyright.pyright

      ov.llvm-vs-code-extensions.vscode-clangd
      ov.webfreak.debug

      ov.sumneko.lua

      ov.jnoortheen.nix-ide

      ov.golang.go

      # Utility
      ov.formulahendry.code-runner
      ov.mkhl.direnv
      ov.asvetliakov.vscode-neovim
      ov.jeanp413.open-remote-ssh
    ];
    mutableExtensionsDir = false; # https://www.reddit.com/r/NixOS/comments/15mohek/installing_vscode_extensions_with_homemanager_not/
    profiles.default.userSettings = rec {
      "update.mode" = "none";

      "editor.wordWrap" = "on";
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.defaultFormatter" = null;
      "editor.formatOnSave" = true;
      "editor.tabSize" = 4;
      "editor.insertSpaces" = true;

      "workbench.iconTheme" = "material-icon-theme";

      # "window.zoomLevel" = 1.5;
      "window.commandCenter" = false;
      "window.dialogStyle" = "custom";
      "window.titleBarStyle" = "custom";
      "window.titleSeparator" = " — ";

      "code-runner.runInTerminal" = true;
      "code-runner.enableAppInsights" = false;

      "vscode-neovim.neovimClean" = true;
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "vscode-neovim.compositeKeys" = {
        "jj" = {
          "command" = "vscode-neovim.escape";
        };
      };

      "[python]"."defaultFormatter" = "ms-python.black-formatter";
      "python.languageServer" = "None"; # use pyright instead of pylance

      "[c]"."defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";

      "[nix]"."editor.tabSize" = 2;
      "nix.formatterPath" = "alejandra";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
          "options" = {
            "nixos"."expr" = "(builtins.getFlake \"${flakeDir}\").nixosConfigurations.${host}.options";
            "home-manager"."expr" = "(builtins.getFlake \"${flakeDir}\").homeConfigurations.\"${username}@${host}\".options";
          };
        };
      };

      "Lua.misc.executablePath" = "${pkgs.lua-language-server}/bin/lua-language-server";
      "[lua]"."editor.tabSize" = 2;
    };
  };

  xdg.configFile."VSCodium/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${vscDir}/keybindings.jsonc";
}
