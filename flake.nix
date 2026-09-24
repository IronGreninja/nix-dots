{
  description = "IronGreninja's NixOS and Home-Manager Flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [(inputs.import-tree [./config ./pkgs])];
      _module.args.npins = import ./npins;
      _module.args.flakeDir = "/home/igreninja/nix-dots";
      perSystem = {pkgs, ...}: {formatter = pkgs.alejandra;};
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    den.url = "github:vic/den/latest";
    import-tree.url = "github:vic/import-tree";
    flake-aspects.url = "github:vic/flake-aspects";

    # channel/release pinning (for when something breaks in latest):
    # nixpkgs.url = "https://releases.nixos.org/nixos/unstable/nixos-26.11pre1040357.e2587caef70c/nixexprs.tar.xz";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz"; # always points to the latest release
    nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nvim-config = {
      url = "github:IronGreninja/nvim-config";
      # url = "git+file:///home/igreninja/nvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dolphin-overlay = {
    #   # url = "github:rumboon/dolphin-overlay"; # re-add when PR#5 is merged
    #   url = "github:MattiDragon/dolphin-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      # inputs.nixpkgs.follows = "nixpkgs"; # prevents downloading two versions of nixpkgs but disables cache
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
