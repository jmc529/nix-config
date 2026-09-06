{
  description = "Joe's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
    git-hooks.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, stylix, git-hooks, nix-vscode-extensions, ... }@inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.flex5 = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
        ./hosts/flex5
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ]; }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.sharedModules = [
            plasma-manager.homeModules.plasma-manager
          ];
        }
      ];
    };

    checks.${system}.pre-commit-check = git-hooks.lib.${system}.run {
      src = ./.;
      hooks.deadnix.enable = true;
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
    };
  };
}
