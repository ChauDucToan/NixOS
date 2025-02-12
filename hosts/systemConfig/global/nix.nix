{
    # Setup flake permanently
    nix.settings.experimental-features = [ 
        "nix-command"
        "flakes"
    ];
}
