# nix-flakes-nixvim

A standalone Neovim distribution built entirely with [Nix Flakes](https://wiki.nixos.org/wiki/Flakes) and [NixVim](https://nix-community.github.io/nixvim/). All plugins, LSP servers, formatters, and keymaps are declared in Nix — no manual plugin manager or imperative configuration required.

## Features

| Category         | Plugin                                                                                                                                                | Details                                                                         |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Theme**        | [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                                                                                           | night style                                                                     |
| **Dashboard**    | [alpha-nvim](https://github.com/goolord/alpha-nvim)                                                                                                   | Start screen with lambda logo and Neovim version                                |
| **File tree**    | [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                                                                                       | Git status icons, auto-close on last window, follow current file                |
| **Icons**        | [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                                                                                   | Custom icons for `.lean` (∀), `lean-toolchain` (∃), `.envrc/.bashrc/.zshrc` ($) |
| **Statusline**   | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                                                                                          | Components hidden when neo-tree is focused                                      |
| **Buffer tabs**  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                                                                                         | Slant separator style with close icons                                          |
| **UI**           | [noice.nvim](https://github.com/folke/noice.nvim)                                                                                                     | Modern floating command line and notifications                                  |
| **Indent**       | [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)                                                                       | Rainbow indent guide lines                                                      |
| **Keybind help** | [which-key.nvim](https://github.com/folke/which-key.nvim)                                                                                             | Keybinding popup on prefix key                                                  |
| **Scrolling**    | [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)                                                                                            | Smooth scrolling for `C-u/d/f/b/e/y`, `zt/zz/zb`                                |
| **Syntax**       | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                                                                                 | 24-language parser set — highlighting + indent                                  |
| **LSP**          | nvim-lspconfig via NixVim                                                                                                                             | See [Language Support](#language-support)                                       |
| **Completion**   | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                                                                                       | LSP, buffer word, and file path sources                                         |
| **Formatting**   | [conform.nvim](https://github.com/stevearc/conform.nvim)                                                                                              | Format-on-save (500 ms timeout) — see [Language Support](#language-support)     |
| **Linting**      | [nvim-lint](https://github.com/mfussenegger/nvim-lint)                                                                                                | [actionlint](https://github.com/rhysd/actionlint) for GitHub Actions workflows  |
| **Git**          | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                                                                           | Added / modified / removed indicators in the sign column                        |
| **AI**           | [copilot.lua](https://github.com/zbirenbaum/copilot.lua)                                                                                              | Auto-trigger inline suggestions                                                 |
| **Autopairs**    | [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                                                                                            | Auto-close brackets and quotes                                                  |
| **Emmet**        | [emmet-vim](https://github.com/mattn/emmet-vim)                                                                                                       | HTML/CSS abbreviation expansion (e.g. `!` → HTML boilerplate)                   |
| **Comments**     | [Comment.nvim](https://github.com/numToStr/Comment.nvim) + [ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Context-aware commenting (JSX/TSX support)                                      |
| **Terminal**     | [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)                                                                                         | Floating terminal toggle                                                        |
| **Preview**      | [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)                                                                              | Live Markdown + Mermaid preview in browser                                      |
| **Navigation**   | [jumpcursor.vim](https://github.com/skanehira/jumpcursor.vim)                                                                                         | Jump cursor to any location in the file                                         |
| **Annotations**  | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                                                                                     | Highlight `TODO`, `FIXME`, `HACK`, `WARN`, `NOTE`, `PERF`, `TEST` and aliases   |

## Language Support

| Language            | LSP               | Formatter          | Treesitter | Notes                                                                                               |
| ------------------- | ----------------- | ------------------ | ---------- | --------------------------------------------------------------------------------------------------- |
| Nix                 | nil_ls            | nixfmt             | ✓          |                                                                                                     |
| Markdown            | marksman          | prettier           | ✓          |                                                                                                     |
| Shell (sh/bash/zsh) | bashls            | shfmt              | ✓          |                                                                                                     |
| TypeScript          | ts_ls             | prettier           | ✓          |                                                                                                     |
| JavaScript          | ts_ls             | prettier           | ✓          |                                                                                                     |
| TSX / JSX           | ts_ls             | prettier           | ✓          | Context-aware commenting via ts-context-commentstring                                               |
| Rust                | rust_analyzer     | rustfmt            | ✓          | cargo and rustc installed automatically by NixVim                                                   |
| Python              | basedpyright      | ruff_format        | ✓          |                                                                                                     |
| Go                  | gopls             | gofumpt            | ✓          |                                                                                                     |
| C                   | clangd            | clang_format       | ✓          |                                                                                                     |
| Java                | jdtls             | google_java_format | ✓          |                                                                                                     |
| Haskell             | hls               | fourmolu           | ✓          | GHC installed automatically by NixVim                                                               |
| OCaml               | ocamllsp          | ocamlformat        | ✓          | Requires `.ocamlformat` file in project root (empty file is fine)                                   |
| Typst               | tinymist          | typstyle           | —          |                                                                                                     |
| HTML                | html              | prettier           | ✓          |                                                                                                     |
| CSS                 | cssls             | prettier           | ✓          |                                                                                                     |
| JSON                | jsonls            | prettier           | ✓          |                                                                                                     |
| YAML                | yamlls            | prettier           | ✓          | GitHub Actions schema auto-applied to `.github/workflows/*.yml`                                     |
| TOML                | taplo             | taplo              | ✓          |                                                                                                     |
| Elm                 | elmls             | elm_format         | ✓          |                                                                                                     |
| R                   | r_language_server | air                | —          | **External dependency**: requires R with `languageserver` installed in the project flake            |
| Julia               | julials           | LSP fallback       | —          | **External dependency**: requires Julia with `LanguageServer.jl` installed in the Julia environment |
| GitHub Actions      | yamlls (schema)   | prettier           | —          | [actionlint](https://github.com/rhysd/actionlint) linter enabled for `.github/workflows/`           |
| Lean 4              | lean.nvim         | —                  | —          | Dedicated plugin with interactive infoview panel                                                    |

## Key Bindings

> `<leader>` and `<LocalLeader>` are both set to `Space`.

### General

| Key      | Mode                     | Action    |
| -------- | ------------------------ | --------- |
| `Ctrl+S` | Normal / Insert / Visual | Save file |

### File Tree (neo-tree)

| Key       | Mode   | Action          |
| --------- | ------ | --------------- |
| `Space e` | Normal | Toggle neo-tree |

### Buffer (bufferline.nvim)

| Key     | Mode                     | Action                |
| ------- | ------------------------ | --------------------- |
| `Alt+l` | Normal / Insert / Visual | Next buffer           |
| `Alt+h` | Normal / Insert / Visual | Previous buffer       |
| `Alt+d` | Normal                   | Close (delete) buffer |

### Completion (nvim-cmp)

| Key      | Mode   | Action                                         |
| -------- | ------ | ---------------------------------------------- |
| `Ctrl+n` | Insert | Select next completion item                    |
| `Ctrl+p` | Insert | Select previous completion item                |
| `Enter`  | Insert | Confirm selected item (no-op if none selected) |

### Comment (Comment.nvim)

| Key      | Mode            | Action                              |
| -------- | --------------- | ----------------------------------- |
| `Ctrl+/` | Normal / Insert | Toggle line comment on current line |
| `Ctrl+/` | Visual          | Toggle line comment on selection    |

### Copilot

| Key               | Mode   | Action                                           |
| ----------------- | ------ | ------------------------------------------------ |
| `Tab`             | Insert | Accept Copilot suggestion (fallback: insert tab) |
| `Alt+]` / `Alt+[` | Insert | Next / Previous suggestion                       |
| `Ctrl+]`          | Insert | Dismiss suggestion                               |

### Emmet (emmet-vim)

| Key        | Mode   | Action                                                  |
| ---------- | ------ | ------------------------------------------------------- |
| `Ctrl+Y ,` | Insert | Expand Emmet abbreviation (e.g. `!` → HTML boilerplate) |

### Navigation

| Key     | Mode   | Action                      |
| ------- | ------ | --------------------------- |
| `Alt+j` | Normal | Jump cursor to any location |

### Terminal (toggleterm.nvim)

| Key     | Mode                       | Action                   |
| ------- | -------------------------- | ------------------------ |
| `Alt+t` | Normal / Insert / Terminal | Toggle floating terminal |

### Preview (markdown-preview.nvim)

| Key     | Mode   | Action                             |
| ------- | ------ | ---------------------------------- |
| `Alt+m` | Normal | Toggle Markdown preview in browser |

### Lean (active in `.lean` buffers, `Space` = LocalLeader)

| Key         | Mode   | Action                                    |
| ----------- | ------ | ----------------------------------------- |
| `Space i`   | Normal | Toggle infoview                           |
| `Space p`   | Normal | Pause infoview                            |
| `Space r`   | Normal | Restart Lean server                       |
| `Space v`   | Normal | Configure infoview options                |
| `Space x`   | Normal | Place infoview pin                        |
| `Space c`   | Normal | Clear all infoview pins                   |
| `Space dx`  | Normal | Place infoview diff pin                   |
| `Space dc`  | Normal | Clear infoview diff pin                   |
| `Space dd`  | Normal | Toggle auto diff pin mode                 |
| `Space dt`  | Normal | Toggle auto diff pin (keep diff pin)      |
| `Space Tab` | Normal | Jump between lean file and infoview       |
| `Space \`   | Normal | Show abbreviation for symbol under cursor |

### Lean Infoview

| Key           | Action                             |
| ------------- | ---------------------------------- |
| `Enter` / `K` | Click a widget or interactive area |
| `gK`          | Select a widget (shift+click)      |
| `Tab` / `J`   | Jump into a tooltip                |
| `Shift+Tab`   | Jump out of a tooltip              |
| `Esc` / `C`   | Clear all open tooltips            |
| `gd`          | Go to definition                   |
| `gD`          | Go to declaration                  |
| `gy`          | Go to type                         |

## Neo-tree Git Status Symbols

| Symbol | Meaning   |
| ------ | --------- |
| `+`    | Added     |
| `~`    | Modified  |
| `✘`    | Deleted   |
| `»`    | Renamed   |
| `?`    | Untracked |
| `◌`    | Ignored   |
| `-`    | Unstaged  |
| `✓`    | Staged    |
| `!`    | Conflict  |

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
├── flake.nix                        # Flake definition (packages & devShell)
├── flake.lock
├── config/
│   ├── default.nix                  # Root NixVim module — imports all modules below
│   └── libs/
│       ├── ui/
│       │   ├── theme.nix            # Colorscheme (tokyonight)
│       │   ├── dashboard.nix        # Start screen (alpha-nvim)
│       │   ├── tree.nix             # Neo-tree + web-devicons
│       │   ├── bar.nix              # Statusline (lualine)
│       │   ├── tab.nix              # Buffer tabs (bufferline)
│       │   ├── gitsigns.nix         # Git gutter signs
│       │   └── utils.nix            # noice / indent-blankline / which-key / neoscroll / todo-comments
│       ├── language/
│       │   ├── lsp.nix              # LSP servers (20+ languages) + lean.nvim
│       │   ├── format.nix           # conform.nvim (format-on-save) + nvim-lint
│       │   └── treesitter.nix       # Syntax highlighting (nvim-treesitter)
│       └── action/
│           ├── copilot.nix          # GitHub Copilot
│           ├── completion.nix       # nvim-cmp + LSP / buffer / path sources
│           ├── commentout.nix       # Comment.nvim + ts-context-commentstring
│           ├── emmet.nix            # Emmet abbreviation expansion (emmet-vim)
│           ├── utils.nix            # autopairs / jumpcursor / toggleterm / markdown-preview
│           └── keymaps.nix          # Global keymaps and leader key
├── .envrc                           # direnv integration
└── .gitignore
```

## References

- [NixVim Documentation](https://nix-community.github.io/nixvim/)
- [NixVim GitHub Repository](https://github.com/nix-community/nixvim)
- [NixVim Standalone Installation Guide](https://nix-community.github.io/nixvim/user-guide/install.html#standalone-usage)
- [Nix Flakes - NixOS Wiki](https://wiki.nixos.org/wiki/Flakes)
- [NixOS/nixpkgs (nixos-unstable)](https://github.com/NixOS/nixpkgs)
