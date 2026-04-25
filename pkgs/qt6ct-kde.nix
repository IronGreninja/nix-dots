{npins, ...}: {
  perSystem = {pkgs, ...}: {
    packages.qt6ct-kde = pkgs.kdePackages.qt6ct.overrideAttrs (oldAttrs: {
      patches = let
        pin = npins.qt6ct-kde-patch;
        patchRepo = pkgs.fetchgit {
          inherit (pin.repository) url;
          inherit (pin) hash;
          rev = pin.revision;
        };
      in
        (oldAttrs.patches or []) ++ [(patchRepo + "/qt6ct-shenanigans.patch")];
      buildInputs = oldAttrs.buildInputs ++ [pkgs.kdePackages.qqc2-desktop-style];
    });
  };
}
