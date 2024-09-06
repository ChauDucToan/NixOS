{
  description = "My first created flake!!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }:
    let
      nix_lib = nixpkgs.lib;
      home_lib = home-manager.lib;

      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

      username = "oslamelon";
      name = "nato";
    in
    {
      nixosConfigurations = {
        oslamelon = nix_lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit pkgs-unstable;
          };
          modules = [
            ./system/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        nato = home_lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit inputs;
          };
          modules = [
            hyprland.homeManagerModules.default
            ./user/home.nix
          ];
        };
      };
    };

}
