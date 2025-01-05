{

  description = "Flake for wayland!!!";

  inputs = {
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nix-gaming, nixpkgs, home-manager, hyprland, ... } @ inputs:
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
	  modules = [ 
        ./system/configuration.nix 
        nix-gaming.nixosModules.pipewireLowLatency

        {
          nix.settings = {
              substituters = [
                "https://nix-gaming.cachix.org"
              ];
              trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
          };
        }
      ];
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
