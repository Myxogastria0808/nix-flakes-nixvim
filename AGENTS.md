# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

A Nix flakes project that builds a standalone Neovim package with declarative configuration using [NixVim](https://nix-community.github.io/nixvim/). Targets `x86_64-linux` (manually verified), `aarch64-darwin`, and `x86_64-darwin` (declared but unverified — no macOS machine available for testing), using `nixos-unstable` channel.

## Commands

```bash
# Build the Neovim package (works in any terminal; chafa character-art image previews)
nix build .#default

# Build the Kitty Graphics Protocol variant (kitty/WezTerm/ghostty; real per-pixel image previews)
nix build .#kitty

# Run the built Neovim directly
nix run .#default    # or .#kitty

# Enter dev shell (includes the built Neovim)
nix develop           # .#default's devShell; `nix develop .#kitty` for the Kitty variant

# Update all flake dependencies
nix flake update
```

Direnv is configured (`.envrc` with `use flake`), so `direnv allow` will auto-load the `default` dev shell.

## Architecture

- **`flake.nix`** — Defines four outputs for each of `x86_64-linux`, `aarch64-darwin`, `x86_64-darwin` (Darwin targets declared but unverified — no macOS machine available for testing):
  - `packages.<system>.default`: Neovim built via `nixvim.makeNixvimWithModule` importing `./config` (→ `config/default.nix`)
  - `packages.<system>.kitty`: same, importing `./config/kitty.nix` instead
  - `devShells.<system>.default` / `devShells.<system>.kitty`: shells containing the matching package
- **`config/base.nix`** — Root NixVim module imported by both variants: every sub-module below except the image-preview one, which differs per variant.
- **`config/default.nix`** — `base.nix` + `libs/ui/image-chafa.nix`. Works in any terminal.
- **`config/kitty.nix`** — `base.nix` + `libs/ui/image-kitty.nix`. For terminals that speak the Kitty Graphics Protocol.

The image-preview feature is the one piece of config that depends on which terminal Neovim runs in — whether it can display real pixel graphics — and that can't be detected at runtime without the complexity and failure modes worked through and rejected here (see git history on `libs/ui/image-kitty.nix` / `libs/ui/image-chafa.nix` for what was tried: image.nvim's Kitty backend opens stdout as a side effect of merely being `require`d, which throws outside a real terminal regardless of whether it ends up used, so a runtime "is this terminal Kitty-capable?" check that decides whether to load it doesn't actually avoid the crash on unsupported terminals — only never loading the module at all does). Splitting into two build-time variants sidesteps this entirely: each variant's module always assumes its target terminal, so neither needs a runtime capability check or a guard against the other backend's failure modes.

The `makeNixvimWithModule` function from NixVim takes a `module` parameter. All Neovim customization should be added under `config/libs/` (via `base.nix`) unless it's terminal-dependent like image preview, using [NixVim module options](https://nix-community.github.io/nixvim/).

## Module Structure

Configuration is split into three categories under `config/libs/`:

### `ui/` — Visual and interface plugins

| File             | Contents                                                                                                                                                                                                                               |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `theme.nix`      | tokyonight colorscheme (night style)                                                                                                                                                                                                   |
| `dashboard.nix`  | alpha-nvim startup screen with geometric ASCII art logo                                                                                                                                                                                |
| `tree.nix`       | neo-tree file explorer + nvim-web-devicons custom icons; netrw disabled (`loaded_netrw` / `loaded_netrwPlugin` = 1); `open_files_do_not_replace_types` guards neo-tree / qf / sagaoutline windows from being used as file-open targets |
| `status-bar.nix` | lualine statusline (hidden in neo-tree windows)                                                                                                                                                                                        |
| `tab.nix`        | bufferline buffer tabs                                                                                                                                                                                                                 |
| `gitsigns.nix`   | gitsigns sign-column git indicators                                                                                                                                                                                                    |
| `notify.nix`     | nvim-notify + noice.nvim floating notifications and UI                                                                                                                                                                                 |
| `utils.nix`      | swapfile off + undofile on, telescope + telescope-undo, indent-blankline, which-key, neoscroll, todo-comments, opts                                                                                                                    |
| `image-chafa.nix` (via `config/default.nix`) | auto-preview images chafa's loaders support (AVIF/GIF/JPEG/JXL/PNG/QOI/SVG/TIFF/WebP/XWD) in the file-open pane via a `BufReadPost` autocmd running `chafa` (sextant symbols, truecolor) in a scratch terminal buffer |
| `image-kitty.nix` (via `config/kitty.nix`) | auto-preview images as real per-pixel graphics via image.nvim's Kitty Graphics Protocol backend — both direct file opens and inline in Markdown/Typst/Neorg/AsciiDoc-reST/HTML/CSS documents (all integrations enabled) |

### `language/` — LSP, formatting, and syntax

| File             | Contents                                                                                                                                                                                 |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lsp.nix`        | nvim-lspconfig (28 language servers) + lean.nvim + cornelis (Agda)                                                                                                                       |
| `lspsaga.nix`    | lspsaga.nvim rich LSP UI + floating terminal                                                                                                                                             |
| `format.nix`     | conform.nvim format-on-save (oxfmt for JS/TS/JSON/YAML/HTML/CSS/Markdown/MDX, prettier for Astro, latexindent for LaTeX, mermaidfmt for Mermaid, dot_canon for Graphviz DOT) + nvim-lint async linting + texliveFull |
| `treesitter.nix` | nvim-treesitter syntax highlighting (38 parsers, MDX built from source, Mermaid and dot from nixpkgs builtGrammars)                                                                      |

### `action/` — Editing and workflow plugins

| File             | Contents                                                                                                    |
| ---------------- | ----------------------------------------------------------------------------------------------------------- |
| `copilot.nix`    | copilot.lua inline AI suggestions                                                                           |
| `completion.nix` | nvim-cmp completion engine (LSP / buffer / path sources)                                                    |
| `commentout.nix` | Comment.nvim + ts-context-commentstring (JSX/TSX-aware)                                                     |
| `emmet.nix`      | emmet-vim HTML/CSS abbreviation expansion                                                                   |
| `utils.nix`      | nvim-autopairs, jumpcursor.vim, markdown-preview.nvim, typst-preview.nvim, LaTeX build keymap (`<leader>b`) |
| `keymaps.nix`    | Global keymaps and leader key (`<Space>`)                                                                   |

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

## Custom-Built Packages

Some tools are not available in nixpkgs and are built from source within this flake:

| Package             | Build method                             | Used by          | Notes                                                                                                     |
| ------------------- | ---------------------------------------- | ---------------- | --------------------------------------------------------------------------------------------------------- |
| tree-sitter-mdx     | `pkgs.tree-sitter.buildGrammar`          | `treesitter.nix` | MDX grammar from [srazzak/tree-sitter-mdx](https://github.com/srazzak/tree-sitter-mdx)                    |
| mdx-language-server | `pkgs.buildNpmPackage` (npm tarball)     | `lsp.nix`        | Requires a vendored `package-lock.json` and `init_options.typescript.tsdk` pointing to the TypeScript SDK |
| mermaid-formatter   | `pkgs.stdenv.mkDerivation` (npm tarball) | `format.nix`     | No runtime deps; dist pre-compiled; binary `mermaidfmt` wrapped via `makeWrapper` around Node.js          |

## File Editing Rules

When creating or editing any file, always ensure it ends with exactly one trailing newline. If the last line is not empty, append a blank line before saving. This is consistent with the `BufWritePre` autocmd in `config/libs/language/format.nix` that enforces trailing newlines on every save.

## Keybinding Rules

**Before suggesting any new keybinding, always grep all existing bindings first:**

```bash
grep -r 'key\s*=' config/
```

Check for conflicts across all `config/**/*.nix` files before proposing a key. Never suggest a key that is already in use.

