# lsp.nix — Language Server Protocol configuration.
# Enables 27 language servers via nvim-lspconfig (NixVim) and lean.nvim for Lean 4.
# r_language_server and julials use package = null (external dependencies required).
# mdx_analyzer is built from the npm tarball using buildNpmPackage.
{ pkgs, ... }:
let
  # mdx-language-server
  # reference: https://github.com/mdx-js/mdx-analyzer
  #
  # Language server for MDX, providing diagnostics, completions, and hover
  # via the Volar framework.
  #
  # mdx_analyzer is listed in NixVim's "unpackaged" servers, meaning NixVim
  # knows how to configure the LSP client but nixpkgs has no pre-built
  # package for it. Normally you would set package = null and rely on the
  # binary being on $PATH (like r_language_server and julials), but here we
  # build it ourselves with buildNpmPackage so the flake is self-contained.
  #
  # The source is fetched from the npm registry tarball (not GitHub) because
  # the upstream repo is a monorepo without a root package-lock.json, which
  # makes buildNpmPackage impractical from the Git source.
  #
  # buildNpmPackage requires a package-lock.json to resolve the dependency
  # tree deterministically. Since the npm tarball does not include one, we
  # vendor a pre-generated lockfile (mdx-language-server-package-lock.json)
  # and symlink it in postPatch.
  #
  # dontNpmBuild = true skips the build phase because the package ships
  # pre-compiled JS — no transpilation or bundling step is needed.
  #
  # npmDepsHash pins the exact dependency tree for Nix's reproducible builds.
  mdx-language-server = pkgs.buildNpmPackage rec {
    pname = "mdx-language-server";
    version = "0.6.3";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/@mdx-js/language-server/-/language-server-${version}.tgz";
      hash = "sha256-rNYJYQjnA7u02nP4a7EL/yJbjGdwP0RLQpAhr/I9xLs=";
    };
    postPatch = ''
      ln -s ${./mdx-language-server-package-lock.json} package-lock.json
    '';
    npmDepsHash = "sha256-fY+lG+eu+hX7RFyWRiGOA1VXEt4hTmud6KB5XDaBeFo=";
    dontNpmBuild = true;
    meta = {
      description = "Language server for MDX";
      homepage = "https://github.com/mdx-js/mdx-analyzer";
      mainProgram = "mdx-language-server";
    };
  };
in
{
  # nvim-lspconfig (via NixVim)
  # reference: https://github.com/neovim/nvim-lspconfig
  #
  # Configures language servers for LSP features (diagnostics, go-to-definition, etc.).
  # Enabled servers:
  #   nil_ls             : Nix                     (reference: https://github.com/oxalica/nil)
  #   marksman           : Markdown                (reference: https://github.com/artempyanykh/marksman)
  #   bashls             : shell scripts           (reference: https://github.com/bash-lsp/bash-language-server)
  #   ts_ls              : TypeScript / JavaScript (reference: https://github.com/typescript-language-server/typescript-language-server)
  #   rust_analyzer      : Rust                    (reference: https://github.com/rust-lang/rust-analyzer)
  #   r_language_server  : R                       (reference: https://github.com/REditorSupport/languageserver)
  #   ocamllsp           : OCaml                   (reference: https://github.com/ocaml/ocaml-lsp)
  #   hls                : Haskell                 (reference: https://github.com/haskell/haskell-language-server)
  #   tinymist           : Typst                   (reference: https://github.com/Myriad-Dreamin/tinymist)
  #   clangd             : C                       (reference: https://clangd.llvm.org)
  #   basedpyright       : Python                  (reference: https://github.com/DetachHead/basedpyright)
  #   html               : HTML                    (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   cssls              : CSS                     (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   jdtls              : Java                    (reference: https://github.com/eclipse-jdtls/eclipse.jdt.ls)
  #   julials            : Julia                   (reference: https://github.com/julia-vscode/LanguageServer.jl)
  #   gopls              : Go                      (reference: https://github.com/golang/tools/tree/master/gopls)
  #   taplo              : TOML                    (reference: https://github.com/tamasfe/taplo)
  #   jsonls             : JSON                    (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   yamlls             : YAML                    (reference: https://github.com/redhat-developer/yaml-language-server)
  #   elmls              : Elm                     (reference: https://github.com/elm-language-server/elm-language-server)
  #   astro              : Astro                   (reference: https://github.com/withastro/language-tools)
  #   dockerls           : Dockerfile              (reference: https://github.com/rcjsuen/dockerfile-language-server)
  #   docker_compose_language_service : Docker Compose (reference: https://github.com/microsoft/compose-language-service)
  #   autotools_ls       : Makefile                (reference: https://github.com/Freed-Wu/autotools-language-server)
  #   mdx_analyzer       : MDX                     (reference: https://github.com/mdx-js/mdx-analyzer)
  #   texlab             : LaTeX                   (reference: https://github.com/latex-lsp/texlab)
  #   asm_lsp            : Assembly (NASM/GAS)     (reference: https://github.com/bergercookie/asm-lsp)
  plugins.lsp = {
    enable = true;
    servers = {
      # Nix language server
      nil_ls.enable = true;
      # Markdown language server
      marksman.enable = true;
      # shell script language server (sh, bash, zsh)
      bashls = {
        enable = true;
        filetypes = [
          "sh"
          "bash"
          "zsh"
        ];
      };
      # TypeScript / JavaScript language server
      ts_ls.enable = true;
      # R language server
      # package = null: relies on R (with languageserver) provided by the project's R flake
      r_language_server = {
        enable = true;
        package = null;
      };
      # OCaml language server
      ocamllsp.enable = true;
      # Haskell language server
      hls = {
        enable = true;
        installGhc = true;
      };
      # Typst language server
      tinymist.enable = true;
      # C language server
      clangd.enable = true;
      # Python language server
      basedpyright.enable = true;
      # HTML language server
      html.enable = true;
      # CSS language server
      cssls.enable = true;
      # Java language server
      jdtls.enable = true;
      # Julia language server
      # package = null: relies on LanguageServer.jl installed in the Julia environment
      julials = {
        enable = true;
        package = null;
      };
      # Go language server
      gopls.enable = true;
      # TOML language server
      taplo.enable = true;
      # JSON language server (included in vscode-langservers-extracted, same as html/cssls)
      jsonls.enable = true;
      # YAML language server
      yamlls = {
        enable = true;
        settings.yaml.schemas = {
          # GitHub Actions workflow schema
          "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
        };
      };
      # Elm language server
      elmls.enable = true;
      # Astro language server
      astro.enable = true;
      # Dockerfile language server
      dockerls.enable = true;
      # Docker Compose language server
      docker_compose_language_service.enable = true;
      # Makefile language server
      autotools_ls.enable = true;
      # MDX language server (built from npm tarball, see let-binding above)
      # enable = true generates the nvim-lspconfig setup for mdx_analyzer.
      # package = mdx-language-server supplies the self-built binary so that
      # NixVim adds bin/mdx-language-server to $PATH. The LSP client then
      # starts it automatically when a buffer with filetype "mdx" is opened.
      #
      # init_options.typescript.tsdk must point to the TypeScript SDK lib
      # directory so that the Volar-based language server can resolve TS/JSX
      # types inside MDX files. Without this, the server exits immediately
      # because the Volar framework requires a TypeScript SDK to initialise.
      #
      # pkgs.typescript is NOT a new external dependency — it is already in
      # the runtime closure via typescript-language-server (ts_ls). We are
      # simply referencing its nix store path here.
      #
      # Note: mdx_analyzer uses root_markers = { "package.json" } by default
      # (from nvim-lspconfig). The LSP will only attach when a package.json
      # exists in the file's ancestor directories, which is the expected
      # behaviour since MDX is typically used in JS/TS projects.
      mdx_analyzer = {
        enable = true;
        package = mdx-language-server;
        extraOptions.init_options.typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
      };
      # LaTeX language server
      texlab.enable = true;
      # Assembly (NASM/GAS) language server
      asm_lsp.enable = true;
      # Rust language server
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };

  # lean.nvim
  # reference: https://github.com/Julian/lean.nvim
  #
  # Provides Lean 4 language support with an interactive infoview panel.
  # <LocalLeader> is set to Space.
  #
  # Keymaps in Lean files:
  # <LocalLeader>i         : toggle the infoview open or closed
  # <LocalLeader>p         : pause the current infoview
  # <LocalLeader>r         : restart the Lean server for the current file
  # <LocalLeader>v         : interactively configure infoview view options
  # <LocalLeader>x         : place an infoview pin
  # <LocalLeader>c         : clear all current infoview pins
  # <LocalLeader>dx        : place an infoview diff pin
  # <LocalLeader>dc        : clear current infoview diff pin
  # <LocalLeader>dd        : toggle auto diff pin mode
  # <LocalLeader>dt        : toggle auto diff pin mode without clearing diff pin
  # <LocalLeader><Tab>     : jump into the infoview window
  # <LocalLeader>\         : show what abbreviation produces the symbol under the cursor
  #
  # Keymaps in Infoview windows:
  # <CR> / K               : click a widget or interactive area
  # gK                     : select a widget ("shift+click")
  # <Tab> / J              : jump into a tooltip
  # <Shift-Tab>            : jump out of a tooltip
  # <Esc> / C              : clear all open tooltips
  # gd                     : go-to-definition
  # gD                     : go-to-declaration
  # gy                     : go-to-type
  # <LocalLeader><Tab>     : jump to the lean file from the infoview
  #
  plugins.lean = {
    enable = true;
    settings = {
      # infoview panel settings
      infoview = {
        height = 10;
        orientation = "horizontal";
        horizontal_position = "bottom";
        indicators = "always";
      };
      # enable the keymaps listed in the header above
      mappings = true;
    };
  };

  # Set commentstring for Lean so Comment.nvim works correctly.
  # Lean line comment: -- comment
  # Lean block comment: /- comment -/
  # ts-context-commentstring has no Lean parser, so we set it manually.
  autoCmd = [
    {
      event = "FileType";
      pattern = "lean";
      command = "setlocal commentstring=--\\ %s";
    }
  ];
}

