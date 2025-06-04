# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  grub-stylish-theme = pkgs.callPackage ./grub-themes/grub-stylish.nix {};

  sddm-vergil-dark-theme = pkgs.libsForQt5.callPackage ./sddm-themes/sddm-vergil-dark.nix {};
  sddm-astronaut-theme = pkgs.callPackage ./sddm-themes/sddm-astronaut-theme.nix {};

  gruvboxPlus-icon-theme = pkgs.callPackage ./icon-themes/gruvbox-plus-icon-theme.nix {};

  gruvbox-gtk-theme = pkgs.callPackage ./gtk-themes/gruvbox-gtk-theme.nix {};
}
