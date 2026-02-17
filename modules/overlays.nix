{
  inputs,
  self,
  lib,
  ...
}: {
  flake.overlays.modifications = final: prev: {
    qt6ct-kde = let
      patch = prev.fetchpatch {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/qt6ct-shenanigans.patch?h=qt6ct-kde";
        sha256 = "1igxin99ia0a5c8j00d43gpvgkwygv2iphjxhw1bx52aqm3054sm"; # nix-prefetch-url
      };
    in
      prev.kdePackages.qt6ct.overrideAttrs (oldAttrs: {
        patches = [patch];
        buildInputs = oldAttrs.buildInputs ++ [prev.kdePackages.qqc2-desktop-style];
      });
  };

  # infinite recursion
  # flake.overlays.additions = final: prev:
  #   self.packages.${final.system};

  flake.overlays.stable-packages = final: _prev:
    lib.optionalAttrs (inputs ? nixpkgs-stable) {
      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
    };
}
