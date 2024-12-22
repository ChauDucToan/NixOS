{

  description = "Flake for wayland!!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
    }:
    let
      nixLib = nixpkgs.lib;
      homeLib = home-manager.lib;

      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      username = "oslamelon";
    in {
      nixosConfigurations = {
        ${username} = nixLib.nixosSystem {
          specialArgs = {  inherit inputs system username;  };
	  modules = [ ./system/configuration.nix ];
	};
      };
      homeConfigurations = {
        ${username} = homeLib.homeManagerConfiguration {
          inherit pkgs;
	  extraSpecialArgs = {  inherit inputs username;  };
	  modules = [  
	    hyprland.homeManagerModules.default
	    ./user/home.nix
	  ];
	};
      };
    };

}
