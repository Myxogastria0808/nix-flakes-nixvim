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

# Show flake outputs
nix flake show
```

Direnv is configured (`.envrc` with `use flake`), so `direnv allow` will auto-load the dev shell.

## Architecture

- **`flake.nix`** — Defines two outputs:
  - `packages.x86_64-linux.default`: Neovim built via `nixvim.makeNixvimWithModule` importing `./config`
  - `devShells.x86_64-linux.default`: Shell containing the built Neovim package
- **`config/default.nix`** — NixVim module where all Neovim configuration goes (plugins, keymaps, options, etc.)

The `makeNixvimWithModule` function from NixVim takes a `module` parameter pointing to `config/default.nix`. All Neovim customization should be added there using [NixVim module options](https://nix-community.github.io/nixvim/).
