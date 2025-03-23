# NixOS config
These are my dotfiles (configuration files) for my NixOS. There still are a lot
of mistakes and improve so stay tune for my new updates.

## NixOS tree
```netrw
~/nix-config
├── flake.nix          # Entry point
├── hosts/             # System-specific configs
│   └── ${HOSTNAME}/
│       ├── tmux/
│       └── home.nix
├── modules/           # Reusable NixOS modules
│   ├── nixOSModules/  # System-wide modules
│   │   └── neovim/
│   └── homeManagerModules/
│       ├── swww/default.nix
│       └── kitty/
└── dev/               # Development shell
      └── clangd/
```
## Neovim tree
This tree I made based on ThePrimeagen's repository
```netrw
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
## How to use
Run the following bash file
```bash
bash ~/NixOS/setup.bash
```
