{
  config,
  lib,
  inputs,
  system,
  username,
  host,
  ...
}: let
  cfg = config.homeSettings.nixvim;
in
  with lib; {
    options.homeSettings.nixvim = {
      enable = mkEnableOption "Install neovim(nixvim)";
      defaultEditor = mkOption {
        type = types.bool;
        default = true;
      };
    };

    config = let
      Pkg = inputs.nvim-dots.packages.${system}.default.extend {
        plugins.lsp.servers.nixd.settings = let
          flake = ''(builtins.getFlake "/home/${username}/nix-dots")'';
        in {
          options = {
            nixos.expr = ''${flake}.nixosConfigurations.${host}.options'';
            home-manager.expr = ''${flake}.homeConfigurations."${username}@${host}".options'';
          };
        };
      };
    in
      mkIf (cfg.enable) {
        home.packages =
          if !config.stylix.targets.nixvim.enable
          then [Pkg]
          else [(Pkg.extend config.lib.stylix.nixvim.config)];
        home.sessionVariables = mkIf cfg.defaultEditor {EDITOR = "nvim";};
      };
  }
