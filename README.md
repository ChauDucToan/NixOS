# NixOS config
These are my dotfiles (configuration files) for my NixOS. There still are a lot
of mistakes and improve so stay tune for my new updates.

## NixOS tree
```
~/nix-config
├── flake.nix          # Entry point
├── hosts/             # System-specific configs
│   └── ${HOSTNAME}/
│       └── tmux/
├── modules/           # Reusable NixOS modules
│   └── neovim/
│       ├── core.nix
│       ├── plugins/
│       └── deps.nix
├── home/              # User-level configs
│     └── ${USERNAME}/
│         └── neovim/
└── dev/               # Development shell
      └── clangd/
```
## Neovim tree
```
nvim/
├── init.lua           # Entry point for each user's configs
└── lua/               # Machine-specific configs
    └── ${CONFIG}/
        ├── lazy/      # Include all plugins
        │   └── vimtex.lua    
        ├── init.lua
        ├── remap.lua
        └── set.lua 
```
