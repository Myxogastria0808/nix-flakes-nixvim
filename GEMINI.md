# GEMINI.md - NixVim Configuration Project

## Project Overview

This project is a standalone, highly-opinionated Neovim distribution built using [NixVim](https://nix-community.github.io/nixvim/) and [Nix Flakes](https://wiki.nixos.org/wiki/Flakes). It manages all plugins, language servers (LSP), formatters, and UI components declaratively via Nix.

-   **Main Technologies:** Nix, NixVim, Neovim (Lua).
-   **Theme:** Tokyonight (Night style).
-   **Architecture:** The configuration is modularized under the `config/` directory.
    -   `flake.nix`: Entry point for the Nix flake, defining packages and devShells.
    -   `config/default.nix`: Root NixVim module that imports all sub-modules.
    -   `config/libs/`: Contains categorized configuration modules:
        -   `ui/`: Theme, dashboard, status bar, tabs, notifications, and file tree.
        -   `language/`: LSP, Treesitter, formatting (conform.nvim), and linting (nvim-lint).
        -   `action/`: Keymaps, completion, Copilot, Emmet, and utility plugins.

## Building and Running

The project leverages Nix for reproducible builds and environments.

-   **Run directly:** `nix run .` (runs the configured Neovim).
-   **Build package:** `nix build .` (creates a `result` symlink to the Neovim executable).
-   **Development environment:** `nix develop` (enters a shell with the configured Neovim in PATH).
-   **Direnv integration:** If `direnv` is installed, running `direnv allow` will automatically load the dev shell upon entering the directory.

## Development Conventions

### Configuration Structure
-   **Modular Imports:** New features or plugins should be added as separate Nix files in `config/libs/` and imported in `config/default.nix`.
-   **Language Support:** Add new LSP servers in `config/libs/language/lsp.nix` and corresponding formatters in `config/libs/language/format.nix`.
-   **Keybindings:**
    -   Global keymaps are in `config/libs/action/keymaps.nix`.
    -   Plugin-specific keymaps are typically co-located with the plugin configuration in their respective modules.
    -   **Leader keys:** Both `<leader>` and `<LocalLeader>` are mapped to `Space`.

### Coding Standards & Automation
-   **Trailing Newline Enforcement:** A custom `BufWritePre` autocmd in `config/libs/language/format.nix` ensures every file ends with exactly one newline on save.
-   **Format-on-save:** Managed by `conform.nvim` with a 500ms timeout and fallback to LSP formatting.
-   **Nix Formatting:** Nix files should be formatted using `nixfmt`.
-   **Linter Integration:** `nvim-lint` is used for non-LSP linting (e.g., `actionlint` for GitHub Actions, `hadolint` for Dockerfiles).

## Key Files

-   `flake.nix`: Defines the flake inputs (nixpkgs, nixvim) and outputs.
-   `config/default.nix`: The "main" entry point for the Neovim configuration.
-   `config/libs/language/lsp.nix`: Configuration for 25+ language servers.
-   `config/libs/language/format.nix`: Centralized formatting logic and tool dependencies.
-   `config/libs/action/keymaps.nix`: Core global keybindings.
-   `README.md`: Comprehensive documentation of features and keybindings.
