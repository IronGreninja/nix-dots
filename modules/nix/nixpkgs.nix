{inputs, ...}: {
  # nixos + hm
  flake.modules.generic.nixpkgs = {
    nixpkgs = {
      overlays = with inputs.self.overlays; [
        # additions
        modifications
        stable-packages
      ];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [];
      };
    };
  };
}
