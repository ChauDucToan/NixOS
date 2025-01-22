# NixOS tree
~/nix-config
├── flake.nix          # Entry point
├── hosts/             # Machine-specific configs
│   └── ${HOSTNAME}/    
│       └── tmux/      # System-invole modules
├── modules/           # Reusable NixOS modules
│   └── neovim/        # Our focus area
│       ├── core.nix   # Base Neovim config
│       ├── plugins/   # Individual plugin modules
│       └── deps.nix   # System dependencies
└── home/              # User-level configs
    └── ${USERNAME}/
        └── neovim/    # Your personal Neovim customizations
# Neovim tree
nvim/
├── init.lua           # Entry point for each user and include to different config
└── lua/               # Machine-specific configs
    └── ${CONFIG}/    
        ├── lazy/      # Include all plugins
        │   └── vimtex.lua    
        ├── init.lua
        ├── remap.lua
        └── set.lua 
