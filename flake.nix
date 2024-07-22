{
  description = "My first created flake!!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      nix_lib = nixpkgs.lib;
      home_lib = home-manager.lib;

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        oslamelon = nix_lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./system/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        nato = home_lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./user/home.nix
          ];
        };
      };
    };

}
