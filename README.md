# nix-flakes-nixvim

A standalone Neovim distribution built entirely with [Nix Flakes](https://wiki.nixos.org/wiki/Flakes) and [NixVim](https://nix-community.github.io/nixvim/). All plugins, LSP servers, formatters, and keymaps are declared in Nix — no manual plugin manager or imperative configuration required.

## Features

| Category         | Details                                                                                                                                                                 |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Color scheme** | [tokyonight](https://github.com/folke/tokyonight.nvim) (night style)                                                                                                    |
| **File tree**    | [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) with git status icons and devicons                                                                           |
| **Statusline**   | [lualine](https://github.com/nvim-lualine/lualine.nvim) (hidden in neo-tree windows)                                                                                    |
| **LSP**          | [nil](https://github.com/oxalica/nil) (Nix), [marksman](https://github.com/artempyanykh/marksman) (Markdown), [lean.nvim](https://github.com/Julian/lean.nvim) (Lean 4) |
| **Formatting**   | [conform.nvim](https://github.com/stevearc/conform.nvim) — `nixfmt` for Nix, `prettier` for Markdown (format-on-save)                                                   |
| **Git**          | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                                                                                             |
| **AI**           | [copilot.lua](https://github.com/zbirenbaum/copilot.lua) with auto-trigger suggestions                                                                                  |

### Key Bindings

| Key               | Mode                     | Action                             |
| ----------------- | ------------------------ | ---------------------------------- |
| `Ctrl+S`          | Normal / Insert / Visual | Save file                          |
| `Space e`         | Normal                   | Toggle neo-tree                    |
| `Tab`             | Insert                   | Accept Copilot suggestion          |
| `Alt+]` / `Alt+[` | Insert                   | Next / Previous Copilot suggestion |
| `Ctrl+]`          | Insert                   | Dismiss Copilot suggestion         |

> Leader key is set to `Space`.

## Prerequisites

- [Nix](https://nixos.org/download/) with [flakes enabled](https://wiki.nixos.org/wiki/Flakes#Enable_flakes_permanently)
- Target platform: `x86_64-linux`

## Setup

### Standalone usage

```bash
# Build the package
nix build github:Myxogastria0808/nix-flakes-nixvim#default

# Or run directly without installing
nix run github:Myxogastria0808/nix-flakes-nixvim#default
```

### Local development

```bash
git clone https://github.com/Myxogastria0808/nix-flakes-nixvim.git
cd nix-flakes-nixvim

# Build and run
nix run .#default

# Or enter a dev shell that includes the built Neovim
nix develop
```

If you have [direnv](https://direnv.net/) installed, simply run `direnv allow` and the dev shell will be loaded automatically.

### Using this config from another flake

You can consume this Neovim package as an input in your own `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim-config.url = "github:Myxogastria0808/nix-flakes-nixvim";
  };

  outputs = { nixpkgs, nixvim-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Example: add to a dev shell
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          nixvim-config.packages.${system}.default
        ];
      };

      # Example: include in a NixOS configuration
      # nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      #   modules = [
      #     ({ ... }: {
      #       environment.systemPackages = [
      #         nixvim-config.packages.${system}.default
      #       ];
      #     })
      #   ];
      # };
    };
}
```

### Copilot authentication

If you want to use GitHub Copilot, run `:Copilot auth` inside Neovim after the first launch.

## Project Structure

```
.
├── flake.nix              # Flake definition (packages & devShell)
├── flake.lock
├── config/
│   ├── default.nix        # Root NixVim module (colorscheme, globals, opts)
│   ├── keymaps.nix        # Key bindings
│   └── plugins/
│       ├── copilot.nix    # GitHub Copilot
│       ├── format.nix     # conform.nvim (format-on-save)
│       ├── gitsigns.nix   # Git gutter signs
│       ├── lsp.nix        # LSP servers & lean.nvim
│       ├── lualine.nix    # Statusline
│       └── tree.nix       # Neo-tree file explorer
├── .envrc                 # direnv integration
└── .gitignore
```

## References

- [NixVim Documentation](https://nix-community.github.io/nixvim/)
- [NixVim GitHub Repository](https://github.com/nix-community/nixvim)
- [NixVim Standalone Installation Guide](https://nix-community.github.io/nixvim/user-guide/install.html#standalone-usage)
- [Nix Flakes - NixOS Wiki](https://wiki.nixos.org/wiki/Flakes)
- [NixOS/nixpkgs (nixos-unstable)](https://github.com/NixOS/nixpkgs)
