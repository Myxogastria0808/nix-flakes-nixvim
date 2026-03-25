# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Nix flakes project that builds a standalone Neovim package with declarative configuration using [NixVim](https://nix-community.github.io/nixvim/). Targets `x86_64-linux` only, using `nixos-unstable` channel.

## Commands

```bash
# Build the Neovim package
nix build .#default

# Run the built Neovim directly
nix run .#default

# Enter dev shell (includes the built Neovim)
nix develop

# Update all flake dependencies
nix flake update
```

Direnv is configured (`.envrc` with `use flake`), so `direnv allow` will auto-load the dev shell.

## Architecture

- **`flake.nix`** — Defines two outputs:
  - `packages.x86_64-linux.default`: Neovim built via `nixvim.makeNixvimWithModule` importing `./config`
  - `devShells.x86_64-linux.default`: Shell containing the built Neovim package
- **`config/default.nix`** — Root NixVim module that imports all sub-modules below.

The `makeNixvimWithModule` function from NixVim takes a `module` parameter pointing to `config/default.nix`. All Neovim customization should be added there using [NixVim module options](https://nix-community.github.io/nixvim/).

## Module Structure

Configuration is split into three categories under `config/libs/`:

### `ui/` — Visual and interface plugins

| File             | Contents                                                    |
| ---------------- | ----------------------------------------------------------- |
| `theme.nix`      | tokyonight colorscheme (night style)                        |
| `dashboard.nix`  | alpha-nvim startup screen with lambda logo                  |
| `tree.nix`       | neo-tree file explorer + nvim-web-devicons custom icons     |
| `status-bar.nix` | lualine statusline (hidden in neo-tree windows)             |
| `tab.nix`        | bufferline buffer tabs                                      |
| `gitsigns.nix`   | gitsigns sign-column git indicators                         |
| `notify.nix`     | nvim-notify + noice.nvim floating notifications and UI      |
| `utils.nix`      | indent-blankline, which-key, neoscroll, todo-comments, opts |

### `language/` — LSP, formatting, and syntax

| File             | Contents                                              |
| ---------------- | ----------------------------------------------------- |
| `lsp.nix`        | nvim-lspconfig (25 language servers) + lean.nvim      |
| `lspsaga.nix`    | lspsaga.nvim rich LSP UI + floating terminal          |
| `format.nix`     | conform.nvim format-on-save + nvim-lint async linting |
| `treesitter.nix` | nvim-treesitter syntax highlighting (35 parsers)      |

### `action/` — Editing and workflow plugins

| File             | Contents                                                 |
| ---------------- | -------------------------------------------------------- |
| `copilot.nix`    | copilot.lua inline AI suggestions                        |
| `completion.nix` | nvim-cmp completion engine (LSP / buffer / path sources) |
| `commentout.nix` | Comment.nvim + ts-context-commentstring (JSX/TSX-aware)  |
| `emmet.nix`      | emmet-vim HTML/CSS abbreviation expansion                |
| `utils.nix`      | nvim-autopairs, jumpcursor.vim, markdown-preview.nvim    |
| `keymaps.nix`    | Global keymaps and leader key (`<Space>`)                |

## Adding Plugins Not in nixpkgs

Use `extraPlugins` with `pkgs.vimUtils.buildVimPlugin`. The module must accept `pkgs` as an argument.

```nix
{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "plugin-name";
      src = pkgs.fetchFromGitHub {
        owner = "owner";
        repo  = "repo";
        rev   = "<commit-sha>";
        hash  = "<sri-hash>";
      };
    })
  ];
}
```

To get the hash and rev, use the `nl` command (nurl wrapper available in this environment):

```bash
nl --hash https://github.com/owner/repo
nl --rev  https://github.com/owner/repo
```

**Important:** New files must be staged with `git add` before running `nix build`, because Nix flakes only see files tracked by git.

## External Dependencies

Some LSP servers require tools installed outside this flake:

| Language | Dependency                                                        |
| -------- | ----------------------------------------------------------------- |
| R        | R with `languageserver` package installed in the project flake    |
| Julia    | Julia with `LanguageServer.jl` installed in the Julia environment |

These are configured with `package = null` in `lsp.nix` so NixVim does not attempt to provide them.

## Keybinding Rules

**Before suggesting any new keybinding, always grep all existing bindings first:**

```bash
grep -r 'key\s*=' config/
```

Check for conflicts across all `config/**/*.nix` files before proposing a key. Never suggest a key that is already in use.
