{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.homeSettings.installFonts;
in {
  options.homeSettings.installFonts = mkEnableOption "Install personal assortment of fonts";

  config = mkIf cfg {
    home.packages = import ./fonts.nix pkgs;
    fonts.fontconfig.enable = true; # enable discovery of fonts installed with home.packages
  };
}
# 'Nerd Font' vs 'Nerd Font Mono': https://github.com/matthewjberger/scoop-nerd-fonts/issues/205
# If a symbol(character/codepoint) is not provided by a font,
# but another font installed on the system provides it, then that is fetched and displayed.
# In kitty, we can either just use a nerdfont, OR,
# use a regular monospace font as default(font_family),
# but specify(map) the codepoints of nerdfont symbols(icons) to be fetched
# and displayed from nerd-fonts.symbols-only(using symbol_map)
# see: https://www.reddit.com/r/KittyTerminal/comments/r5hssh/comment/hmnbxon/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
# (first option works for me)
# (Note: Normal font + without mapping to nerd-fonts.symbols-only results in display of small icons(likely due to using NFM?))
# Konsole doesn't support selective mapping of codepoints,
# so we have to use a nerdfont to not get small symbol.

