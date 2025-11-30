{
  description = "IronGreninja's NixOS and Home-Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    stylix = {
      url = "github:danth/stylix";
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

    nvim-dots = {
      url = "github:IronGreninja/nvim-dots";
      # url = "git+file:///home/igreninja/nvim-dots";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats = {
      url = "github:IronGreninja/nvim-nixcats";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    # Supported systems for your flake packages, formatter
    systems = ["x86_64-linux"];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = lib.genAttrs systems;

    allHostOptions = lib.genAttrs ["nero" "nephis"] (host: import ./hosts/${host}/hostOptions.nix);

    mkSystem = system: host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit username inputs outputs host system flakeDir;
          hostOptions = import ./hosts/${host}/hostOptions.nix;
        };
        modules = [./system];
      };

    mkHome = system: host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit username inputs outputs host system flakeDir;
          hostOptions = import ./hosts/${host}/hostOptions.nix;
        };
        modules = [./home];
      };

    username = "igreninja";
    flakeDir = "/home/${username}/nix-dots";
  in {
    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeModules = import ./modules/home-manager;

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .  [or .#hostname]'
    nixosConfigurations = {
      nero = mkSystem "x86_64-linux" "nero";
      nephis = mkSystem "x86_64-linux" "nephis";
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .  [ or .#username@hostname]'
    homeConfigurations = {
      "${username}@nero" = mkHome "x86_64-linux" "nero";
      "${username}@nephis" = mkHome "x86_64-linux" "nephis";
    };
  };
}
