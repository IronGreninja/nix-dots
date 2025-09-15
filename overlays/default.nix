{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # fixed in nixpkgs
    #   pdfarranger1_12_1 = prev.pdfarranger.overrideAttrs (oldAttrs: rec {
    #     version = "1.12.1";
    #     src = prev.fetchFromGitHub {
    #       owner = oldAttrs.pname;
    #       repo = oldAttrs.pname;
    #       tag = version;
    #       hash = "sha256-of1itPubf6LBJ4rSh1bca3yoNTiz5Qt9ar9XDe4nhxI=";
    #     };
    #   });
    qt6ct-kde = let
      patch = prev.fetchurl {
        url = "https://aur.archlinux.org/cgit/aur.git/plain/qt6ct-shenanigans.patch?h=qt6ct-kde";
        hash = "sha256-8PtmLV/sf1Uhqz5pQ+6uRzqcCQ7GpBipVkmlI1p9c6M=";
      };
    in
      prev.kdePackages.qt6ct.overrideAttrs (oldAttrs: {
        patches = [patch];
        buildInputs = oldAttrs.buildInputs ++ [prev.kdePackages.qqc2-desktop-style];
      });
  };

  # stable nixpkgs set (declared in flake inputs)
  # will be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
