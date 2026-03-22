# nix-flakes-nixvim

A standalone Neovim distribution built entirely with [Nix Flakes](https://wiki.nixos.org/wiki/Flakes) and [NixVim](https://nix-community.github.io/nixvim/). All plugins, LSP servers, formatters, and keymaps are declared in Nix — no manual plugin manager or imperative configuration required.

## Features

| Category          | Plugin                                                                                                                                                | Details                                                                                                                                                                                                                                                           |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Theme**         | [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                                                                                           | night style                                                                                                                                                                                                                                                       |
| **Dashboard**     | [alpha-nvim](https://github.com/goolord/alpha-nvim)                                                                                                   | Start screen with lambda logo and Neovim version                                                                                                                                                                                                                  |
| **File tree**     | [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)                                                                                       | Git status icons, auto-close on last window, follow current file                                                                                                                                                                                                  |
| **Icons**         | [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                                                                                   | Custom icons for `.lean` (∀), `lean-toolchain` (∃), `.envrc/.bashrc/.zshrc` ($)                                                                                                                                                                                   |
| **Statusline**    | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                                                                                          | Components hidden when neo-tree is focused                                                                                                                                                                                                                        |
| **Buffer tabs**   | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                                                                                         | Slant separator style with close icons                                                                                                                                                                                                                            |
| **Notifications** | [nvim-notify](https://github.com/rcarriga/nvim-notify)                                                                                                | Fancy notification popups (ERROR / WARN / INFO) used as noice.nvim backend                                                                                                                                                                                        |
| **UI**            | [noice.nvim](https://github.com/folke/noice.nvim)                                                                                                     | Modern floating command line and notifications                                                                                                                                                                                                                    |
| **Indent**        | [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)                                                                       | Rainbow indent guide lines                                                                                                                                                                                                                                        |
| **Keybind help**  | [which-key.nvim](https://github.com/folke/which-key.nvim)                                                                                             | Keybinding popup on prefix key                                                                                                                                                                                                                                    |
| **Scrolling**     | [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)                                                                                            | Smooth scrolling for `C-u/d/f/b/e/y`, `zt/zz/zb`                                                                                                                                                                                                                  |
| **Syntax**        | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                                                                                 | 35-parser set — highlighting + indent                                                                                                                                                                                                                             |
| **LSP**           | nvim-lspconfig via NixVim                                                                                                                             | See [Language Support](#language-support)                                                                                                                                                                                                                         |
| **LSP UI**        | [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim)                                                                                               | Rich float UI for hover, diagnostics, finder, rename, code action, outline, breadcrumbs, call hierarchy, float terminal                                                                                                                                           |
| **Completion**    | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                                                                                       | LSP, buffer word, and file path sources                                                                                                                                                                                                                           |
| **Formatting**    | [conform.nvim](https://github.com/stevearc/conform.nvim)                                                                                              | Format-on-save (500 ms timeout) — see [Language Support](#language-support)                                                                                                                                                                                       |
| **Linting**       | [nvim-lint](https://github.com/mfussenegger/nvim-lint)                                                                                                | [actionlint](https://github.com/rhysd/actionlint) (GitHub Actions), [hadolint](https://github.com/hadolint/hadolint) (Dockerfile), [tflint](https://github.com/terraform-linters/tflint) (Terraform), [checkmake](https://github.com/mrtazz/checkmake) (Makefile) |
| **Git**           | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                                                                                           | Added / modified / removed indicators in the sign column                                                                                                                                                                                                          |
| **AI**            | [copilot.lua](https://github.com/zbirenbaum/copilot.lua)                                                                                              | Auto-trigger inline suggestions                                                                                                                                                                                                                                   |
| **Autopairs**     | [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                                                                                            | Auto-close brackets and quotes                                                                                                                                                                                                                                    |
| **Emmet**         | [emmet-vim](https://github.com/mattn/emmet-vim)                                                                                                       | HTML/CSS abbreviation expansion (e.g. `!` → HTML boilerplate)                                                                                                                                                                                                     |
| **Comments**      | [Comment.nvim](https://github.com/numToStr/Comment.nvim) + [ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Context-aware commenting (JSX/TSX support)                                                                                                                                                                                                                        |
| **Terminal**      | [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) (`term_toggle`)                                                                               | Floating terminal toggle (via lspsaga)                                                                                                                                                                                                                            |
| **Preview**       | [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)                                                                              | Live Markdown + Mermaid preview in browser                                                                                                                                                                                                                        |
| **Navigation**    | [jumpcursor.vim](https://github.com/skanehira/jumpcursor.vim)                                                                                         | Jump cursor to any location in the file                                                                                                                                                                                                                           |
| **Annotations**   | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                                                                                     | Highlight `TODO`, `FIXME`, `HACK`, `WARN`, `NOTE`, `PERF`, `TEST` and aliases                                                                                                                                                                                     |

## Language Support

| Language            | LSP                             | Formatter          | Treesitter | Notes                                                                                                                            |
| ------------------- | ------------------------------- | ------------------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Nix                 | nil_ls                          | nixfmt             | ✓          |                                                                                                                                  |
| Markdown            | marksman                        | prettier           | ✓          |                                                                                                                                  |
| Shell (sh/bash/zsh) | bashls                          | shfmt              | ✓          |                                                                                                                                  |
| TypeScript          | ts_ls                           | prettier           | ✓          |                                                                                                                                  |
| JavaScript          | ts_ls                           | prettier           | ✓          |                                                                                                                                  |
| TSX / JSX           | ts_ls                           | prettier           | ✓          | Context-aware commenting via ts-context-commentstring                                                                            |
| Rust                | rust_analyzer                   | rustfmt            | ✓          | cargo and rustc installed automatically by NixVim                                                                                |
| Python              | basedpyright                    | ruff_format        | ✓          |                                                                                                                                  |
| Go                  | gopls                           | gofumpt            | ✓          |                                                                                                                                  |
| C                   | clangd                          | clang_format       | ✓          |                                                                                                                                  |
| Java                | jdtls                           | google_java_format | ✓          |                                                                                                                                  |
| Haskell             | hls                             | fourmolu           | ✓          | GHC installed automatically by NixVim                                                                                            |
| OCaml               | ocamllsp                        | ocamlformat        | ✓          | Requires `.ocamlformat` file in project root (empty file is fine)                                                                |
| Typst               | tinymist                        | typstyle           | ✓          |                                                                                                                                  |
| HTML                | html                            | prettier           | ✓          |                                                                                                                                  |
| CSS                 | cssls                           | prettier           | ✓          |                                                                                                                                  |
| JSON                | jsonls                          | prettier           | ✓          |                                                                                                                                  |
| YAML                | yamlls                          | prettier           | ✓          | GitHub Actions schema auto-applied to `.github/workflows/*.yml`                                                                  |
| TOML                | taplo                           | taplo              | ✓          |                                                                                                                                  |
| Elm                 | elmls                           | elm_format         | ✓          |                                                                                                                                  |
| R                   | r_language_server               | air                | ✓          | **External dependency**: requires R with `languageserver` installed in the project flake                                         |
| Julia               | julials                         | LSP fallback       | ✓          | **External dependency**: requires Julia with `LanguageServer.jl` installed in the Julia environment                              |
| GitHub Actions      | yamlls (schema)                 | prettier           | —          | [actionlint](https://github.com/rhysd/actionlint) linter enabled for `.github/workflows/`                                        |
| Lean 4              | lean.nvim                       | —                  | —          | Dedicated plugin with interactive infoview panel; nvim-treesitter has no Lean grammar (lean.nvim handles its own syntax support) |
| Astro               | astro                           | prettier           | ✓          |                                                                                                                                  |
| Dockerfile          | dockerls                        | —                  | ✓          | [hadolint](https://github.com/hadolint/hadolint) linter enabled                                                                  |
| Docker Compose      | docker_compose_language_service | —                  | —          |                                                                                                                                  |
| Terraform           | terraformls                     | terraform_fmt      | ✓          | [tflint](https://github.com/terraform-linters/tflint) linter enabled; applies to `.tf` and `.tfvars`                             |
| HCL                 | —                               | —                  | ✓          | Treesitter only                                                                                                                  |
| Makefile            | autotools_ls                    | —                  | ✓          | [checkmake](https://github.com/mrtazz/checkmake) linter enabled                                                                  |
| Assembly (GAS/NASM) | asm_lsp                         | —                  | ✓          | `asm` + `nasm` grammars                                                                                                          |

## Key Bindings

> [!NOTE]
> `<leader>` and `<LocalLeader>` are both set to `Space`.

### General

| Key               | Mode                                | Action                           |
| ----------------- | ----------------------------------- | -------------------------------- |
| `Ctrl+S`          | Normal / Insert / Visual            | Save file                        |
| `Alt+L`           | Normal / Insert / Visual            | Toggle line wrap                 |
| `gx`              | Normal                              | Open URL under cursor in browser |
| `Ctrl+Left Click` | Normal / Insert / Visual / Terminal | Open URL under cursor in browser |

> [!NOTE]
> `clipboard = "unnamedplus"` is set, so yank (`y`), delete (`d`), change (`c`), cut (`x`), and substitute (`s`) operations are automatically synced to the system clipboard.

> [!NOTE]
> ctags is explicitly disabled (`tags = ""`).

> [!NOTE]
> Mouse support is enabled for all modes (`mouse = "a"`).

### Notifications (nvim-notify)

| Key     | Mode                                          | Action                            |
| ------- | --------------------------------------------- | --------------------------------- |
| `Alt+Q` | Normal / Insert / Visual / Terminal / Command | Dismiss all visible notifications |

### File Tree (neo-tree)

| Key       | Mode   | Action          |
| --------- | ------ | --------------- |
| `Space e` | Normal | Toggle neo-tree |

### Buffer (bufferline.nvim)

| Key     | Mode                     | Action                |
| ------- | ------------------------ | --------------------- |
| `Alt+]` | Normal / Insert / Visual | Next buffer           |
| `Alt+[` | Normal / Insert / Visual | Previous buffer       |
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

| Key     | Mode   | Action                    |
| ------- | ------ | ------------------------- |
| `Alt+z` | Insert | Expand Emmet abbreviation |

#### Usage

Type an abbreviation in insert mode, then press `Alt+z` to expand it.

**Custom snippet — HTML boilerplate (`!`)**

```
! → Alt+z
```

Expands to:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    |
  </body>
</html>
```

(`|` is the cursor position after expansion.)

**Standard Emmet abbreviations**

| Abbreviation      | Expands to                             |
| ----------------- | -------------------------------------- |
| `div`             | `<div></div>`                          |
| `div.container`   | `<div class="container"></div>`        |
| `div#app`         | `<div id="app"></div>`                 |
| `ul>li*3`         | `<ul>` with three `<li></li>` children |
| `a[href="#"]`     | `<a href="#"></a>`                     |
| `p>{Hello }+span` | `<p>Hello <span></span></p>`           |
| `input:text`      | `<input type="text">`                  |

#### Configuration notes (why it works this way)

emmet-vim's default design uses a **leader key** (e.g. `Ctrl+Y`) followed by a suffix (`,` to expand, `;` for word-expand, `u` to update tag, etc.), creating a family of insert-mode mappings all starting with that prefix.

This causes a problem: as soon as any key is bound as a leader, Neovim enters "wait for the next key" state whenever that leader is pressed in insert mode — even if you only want to use the key for something else. Setting `Ctrl+Y` as the leader, for example, would block neoscroll from using it.

To avoid this, the leader key is set to `<Plug>(emmet-leader)`. `<Plug>` sequences cannot be triggered directly from the keyboard, so all of emmet's built-in leader-based mappings become unreachable. A single explicit keymap (`Alt+z` → `<Plug>(emmet-expand-abbr)`) is then added to expose only the abbreviation expansion action.

Additionally, the bundled `emmet_utils.lua` requires `nvim-treesitter.ts_utils`, a module removed in nvim-treesitter v1. This is patched at startup by overriding `package.loaded["emmet_utils"]` with an equivalent implementation using the current `vim.treesitter.get_node()` API.

### Navigation

| Key     | Mode   | Action                      |
| ------- | ------ | --------------------------- |
| `Alt+j` | Normal | Jump cursor to any location |

### LSP UI (lspsaga.nvim)

| Key     | Mode              | Action                                              |
| ------- | ----------------- | --------------------------------------------------- |
| `K`     | Normal            | Hover documentation (press `K` again to scroll)     |
| `Alt+f` | Normal            | Finder — references / definitions / implementations |
| `gp`    | Normal            | Peek definition (float, no jump)                    |
| `gd`    | Normal            | Go to definition                                    |
| `gP`    | Normal            | Peek type definition (float, no jump)               |
| `gT`    | Normal            | Go to type definition                               |
| `Alt+r` | Normal            | Rename symbol project-wide                          |
| `Alt+a` | Normal / Visual   | Code action with live preview                       |
| `Alt+e` | Normal            | Show line diagnostics                               |
| `Alt+E` | Normal            | Show cursor diagnostics                             |
| `]d`    | Normal            | Jump to next diagnostic                             |
| `[d`    | Normal            | Jump to previous diagnostic                         |
| `Alt+o` | Normal            | Toggle symbol outline panel                         |
| `Alt+i` | Normal            | Show incoming call hierarchy                        |
| `Alt+u` | Normal            | Show outgoing call hierarchy                        |
| `gi`    | Normal            | Show implementations                                |
| `Alt+t` | Normal / Terminal | Toggle floating terminal                            |

> [!NOTE]
> Inside any lspsaga float window: `Ctrl+f` / `Ctrl+b` to scroll down / up.

### Terminal (lspsaga.nvim)

| Key     | Mode              | Action                   |
| ------- | ----------------- | ------------------------ |
| `Alt+t` | Normal / Terminal | Toggle floating terminal |

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
| `⇡`    | Ahead     |
| `⇣`    | Behind    |
| `⇕`    | Diverged  |
| `$`    | Stashed   |

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
│       │   ├── notify.nix           # nvim-notify + noice.nvim (notification routing)
│       │   └── utils.nix            # indent-blankline / which-key / neoscroll / todo-comments
│       ├── language/
│       │   ├── lsp.nix              # LSP servers (30+ languages) + lean.nvim
│       │   ├── lspsaga.nix          # lspsaga.nvim (rich LSP UI + float terminal)
│       │   ├── format.nix           # conform.nvim (format-on-save) + nvim-lint
│       │   └── treesitter.nix       # Syntax highlighting (nvim-treesitter)
│       └── action/
│           ├── copilot.nix          # GitHub Copilot
│           ├── completion.nix       # nvim-cmp + LSP / buffer / path sources
│           ├── commentout.nix       # Comment.nvim + ts-context-commentstring
│           ├── emmet.nix            # Emmet abbreviation expansion (emmet-vim)
│           ├── utils.nix            # autopairs / jumpcursor / markdown-preview
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
