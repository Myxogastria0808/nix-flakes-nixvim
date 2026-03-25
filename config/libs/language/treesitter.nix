{ pkgs, ... }:
{
  # nvim-treesitter
  # reference: https://github.com/nvim-treesitter/nvim-treesitter
  #
  # Provides accurate syntax highlighting and structural code analysis
  # using language-specific parsers.
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      bash
      python
      javascript
      typescript
      tsx
      rust
      c
      go
      java
      haskell
      ocaml
      elm
      r
      julia
      typst
      html
      css
      json
      yaml
      toml
      markdown
      markdown_inline
      lua
      vim
      vimdoc
      regex
      comment
      astro
      dockerfile
      make
      asm
      nasm
    ];
  };
}

