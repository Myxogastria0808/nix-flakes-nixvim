# treesitter.nix — Syntax highlighting and indent using nvim-treesitter.
# Enables 34 language parsers with highlight and indent support.
# MDX grammar is built from source (not in nixpkgs builtGrammars).
{ pkgs, ... }:
let
  # tree-sitter-mdx
  # reference: https://github.com/srazzak/tree-sitter-mdx
  #
  # MDX grammar is not available in nixpkgs builtGrammars,
  # so we build it from source using pkgs.tree-sitter.buildGrammar.
  # buildGrammar compiles src/parser.c and src/scanner.c from the repo
  # into a shared library (.so) that treesitter can load at runtime.
  # The repo also ships query files (highlights.scm, injections.scm, etc.)
  # under queries/, which are copied into the build output automatically.
  treesitter-mdx = pkgs.tree-sitter.buildGrammar {
    language = "mdx";
    version = "0.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "srazzak";
      repo = "tree-sitter-mdx";
      rev = "3aa29e8de1bf0213948a04fe953039b6ab73777b";
      hash = "sha256-Y1m8xBNg25HBGAxbcKPCv0z+vQxbPWevqZc9lrgkr4Y=";
    };
    meta.homepage = "https://github.com/srazzak/tree-sitter-mdx";
  };
in
{
  # nvim-treesitter
  # reference: https://github.com/nvim-treesitter/nvim-treesitter
  #
  # Provides accurate syntax highlighting and structural code analysis
  # using language-specific parsers.
  #
  # Enabled parsers (34 total):
  #   nix, bash, python, javascript, typescript, tsx, rust, c, go, java,
  #   haskell, ocaml, elm, r, julia, typst, html, css, json, yaml, toml,
  #   markdown, markdown_inline, lua, vim, vimdoc, regex, comment,
  #   astro, dockerfile, make, asm, nasm, mdx
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
    ] ++ [
      # Append the custom-built MDX grammar to the list of built-in grammars.
      # This makes treesitter aware of the MDX parser so it can parse .mdx files.
      #
      # grammarPackages handles both the compiled parser library (.so) and the
      # query files (highlights.scm, injections.scm, etc.) — they are bundled
      # into the nvim-treesitter-grammars pack automatically, so there is no
      # need to add treesitter-mdx to extraPlugins separately.
      #
      # languageRegister is also unnecessary here because the parser name
      # ("mdx") matches the filetype name ("mdx") exactly, which treesitter
      # resolves automatically.
      treesitter-mdx
    ];
  };

  # Register .mdx as the "mdx" filetype via vim.filetype.add().
  # Neovim does not recognise the .mdx extension by default, so without
  # this registration the buffer filetype would remain empty when opening
  # an MDX file, and none of treesitter / LSP / conform would activate.
  filetype.extension.mdx = "mdx";
}

