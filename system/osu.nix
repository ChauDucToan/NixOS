{pkgs, inputs, ...}: {

  environment.systemPackages = let
    nix-gaming = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
  in [ 
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable # installs a package
    
    nix-gaming.osu-stable.override rec {
      wine = pkgs.wineWowPackages.unstableFull;
      wine-discord-ipc-bridge = nix-gaming.wine-discord-ipc-bridge.override {inherit wine;}; # or override this one as well
    }
  ];

 
}
