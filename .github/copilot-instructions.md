# Copilot Instructions for nix-flakes-nixvim

## Project Overview

A standalone Neovim distribution built entirely with Nix Flakes and NixVim, targeting `x86_64-linux` only. All plugins, LSP servers, formatters, and keymaps are declared in Nix — no manual plugin manager or imperative configuration required.

## Build & Run Commands

```bash
# Build the Neovim package
nix build .#default

# Run built Neovim directly
nix run .#default

# Enter dev shell (includes built Neovim in PATH)
nix develop

# Update all flake dependencies
nix flake update
```

**Direnv:** If direnv is installed, run `direnv allow` to auto-load the dev shell when entering the directory (configured via `.envrc`).

## Architecture

The configuration is completely declarative:

- **Entry point:** `flake.nix` defines two outputs:
  - `packages.x86_64-linux.default`: Neovim built via `nixvim.makeNixvimWithModule` pointing to `./config`
  - `devShells.x86_64-linux.default`: Shell containing the built Neovim package

- **Root module:** `config/default.nix` imports all sub-modules

- **Module imports all configs from:** `config/libs/` (three categories):
  - **`ui/`** — Theme, dashboard, file tree, statusline, buffer tabs, notifications, git signs, indent guides, key binding help, scrolling
  - **`language/`** — LSP (25+ servers), lspsaga UI, format-on-save, treesitter syntax (33 parsers), async linting
  - **`action/`** — Keymaps, completion engine, copilot, emmet, commenting, autopairs, floating terminal, markdown preview, jump cursor, todo annotations

All Neovim customization is done using [NixVim module options](https://nix-community.github.io/nixvim/).

## Key Conventions

### Trailing Newlines

Every file must end with exactly one trailing newline. This is enforced by a `BufWritePre` autocmd in `config/libs/language/format.nix`. When creating/editing files, ensure the last line is blank.

### Keybindings

- Global keymaps live in `config/libs/action/keymaps.nix`
- Plugin-specific keymaps are co-located with their plugin configuration in the respective module
- **Leader key:** Both `<leader>` and `<LocalLeader>` are mapped to `<Space>`
- **Before proposing new keybindings:** Always check for conflicts:
  ```bash
  grep -r 'key\s*=' config/
  ```
  Never suggest a key that is already in use.

### Format-on-Save

- Managed by `conform.nvim` with 500ms timeout and LSP fallback
- `nixfmt` is used for Nix files
- `nvim-lint` provides async linting (e.g., actionlint for GitHub Actions, hadolint for Dockerfiles)

### Adding Plugins Not in nixpkgs

Use `extraPlugins` with `pkgs.vimUtils.buildVimPlugin`. The module must accept `pkgs` as an argument:

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

Get hash and rev using:

```bash
nl --hash https://github.com/owner/repo
nl --rev  https://github.com/owner/repo
```

**Important:** New files must be staged with `git add` before running `nix build` — Nix flakes only see files tracked by git.

### External Dependencies

Some LSP servers require tools installed outside the flake:

| Language | Requirement                                                       |
| -------- | ----------------------------------------------------------------- |
| R        | R with `languageserver` package installed in the project flake    |
| Julia    | Julia with `LanguageServer.jl` installed in the Julia environment |

These are configured with `package = null` in `lsp.nix` so NixVim does not attempt to provide them.

## Language Support

The distribution includes:

- **LSP:** 25+ language servers (Nix, Python, Rust, Go, TypeScript, etc.)
- **Formatters:** prettier, nixfmt, ruff_format, rustfmt, gofumpt, clang_format, etc.
- **Treesitter:** 33 language parsers for syntax highlighting and indentation
- **Special support:** Context-aware commenting for JSX/TSX, GitHub Actions schema for YAML, Mermaid preview for Markdown

See README.md for the complete language support matrix.

## Testing & Validation

There are no automated tests in this project. Validation is manual:

- Build with `nix build .#default` to catch Nix errors
- Test plugins and keybindings by running `nix run .#default`
- Use `nix flake check` (if available) for flake-level validation

## File Organization Tips

- Keep related plugin config in one `.nix` file (e.g., all lspsaga config stays in `config/libs/language/lspsaga.nix`)
- Import new modules in `config/default.nix`
- Avoid inline Lua where possible; leverage NixVim's declarative options
- Use descriptive variable and function names — the configuration is self-documenting

