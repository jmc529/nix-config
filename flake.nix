{
  description = "Joe's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:4evy/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, git-hooks, home-manager, musnix, nixcord, nixpkgs, nix-vscode-extensions, plasma-manager, sops-nix, stylix, ... }@inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    pkgs = nixpkgs.legacyPackages.${system};

    mkHost = hostPath: nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        hostPath
        home-manager.nixosModules.home-manager
        musnix.nixosModules.musnix
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        { nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ]; }
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            sharedModules = [
              plasma-manager.homeModules.plasma-manager
            ];
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      flex5 = mkHost ./hosts/flex5;
      aorus = mkHost ./hosts/aorus;
    };

    checks.${system}.pre-commit-check = git-hooks.lib.${system}.run {
      src = ./.;
      hooks.deadnix.enable = true;
      hooks.statix.enable = true;
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
    };
  };
}
