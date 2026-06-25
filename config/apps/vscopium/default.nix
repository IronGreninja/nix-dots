{inputs, ...}: {
  ig.apps._.vscopium.homeManager = {
    pkgs,
    lib,
    ...
  }: let
    ext = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
    ov = ext.open-vsx;
    vm = ext.vscode-marketplace;
    ve = pkgs.vscode-extensions;
  in {
    programs.vscodium = {
      enable = true;
      # package = pkgs.vscodium.fhsWithPackages (ps: with ps; []);
      # package = pkgs.vscodium;

      profiles.default.extensions = [
        # Look n Feel
        ve.pkief.material-product-icons
        ve.pkief.material-icon-theme
        # ov.sainnhe.gruvbox-material # deprecated

        # Language support
        ve.ms-python.python
        # ov.ms-python.black-formatter
        ve.charliermarsh.ruff
        ve.ms-python.debugpy
        ve.ms-pyright.pyright

        ve.llvm-vs-code-extensions.vscode-clangd
        # ov.webfreak.debug
        ve.vadimcn.vscode-lldb
        ve.ms-vscode.cmake-tools

        ve.sumneko.lua

        ve.jnoortheen.nix-ide

        ve.golang.go

        # Utility
        # ve.formulahendry.code-runner
        ve.mkhl.direnv
        ve.asvetliakov.vscode-neovim
        # ve.jeanp413.open-remote-ssh
      ];
      mutableExtensionsDir = false;
      profiles.default.userSettings = {
        "update.mode" = "none";

        "editor.wordWrap" = "on";
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.defaultFormatter" = null;
        "editor.formatOnSave" = true;
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;

        "workbench.iconTheme" = "material-icon-theme";
        "workbench.productIconTheme" = "material-product-icons";

        # "window.zoomLevel" = 1.5;
        "window.commandCenter" = false;
        "window.dialogStyle" = "custom";
        "window.titleBarStyle" = "custom";
        "window.titleSeparator" = " — ";

        "code-runner.runInTerminal" = true;
        "code-runner.enableAppInsights" = false;

        # "vscode-neovim.neovimClean" = true;
        "extensions.experimental.affinity" = {
          "asvetliakov.vscode-neovim" = 1;
        };
        "vscode-neovim.compositeKeys" = {
          "jj" = {
            "command" = "vscode-neovim.escape";
          };
        };

        "notebook.formatOnSave.enabled" = true;

        "[python]"."defaultFormatter" = "charliermarsh.ruff";
        "[python]"."editor.codeActionsOnSave"."source.organizeImports" = "explicit";
        "python.languageServer" = "None"; # use pyright instead of pylance

        "[c]"."defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";

        "[nix]"."editor.tabSize" = 2;
        "nix.formatterPath" = "alejandra";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${lib.getExe pkgs.nixd}";
        # FIXME:
        # "nix.serverSettings" = {
        #   "nixd" = {
        #     "formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
        #     "options" = {
        #       "nixos"."expr" = "(builtins.getFlake \"${flakeDir}\").nixosConfigurations.${host}.options";
        #       "home-manager"."expr" = "(builtins.getFlake \"${flakeDir}\").homeConfigurations.\"${username}@${host}\".options";
        #     };
        #   };
        # };

        "Lua.misc.executablePath" = "${lib.getExe pkgs.lua-language-server}";
        "[lua]"."editor.tabSize" = 2;
      };
    };

    xdg.configFile."VSCodium/User/keybindings.json".source = ./keybindings.jsonc;
  };
}
