{
  description = "Joe's NixOS configuration";

  inputs = {
    # TODO check if I need this
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-vscode-extensions = {
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO verify branch
    winapps = {
      url = "github:winapps-ord/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, stylix,, nixos-hardware, nix-vscode-extensions, winapps, ... }@inputs:
    let ;
      specialArgs = {inherit inputs; }
    in
    {
      nixosConfigurations.flex5 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          .hosts/flex5
          stylix.nixosModules.stylix
          { nixpkgs.overlays = [ nix-vscode-extensions.overlay.default ]; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserOackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
      };
    };
}
