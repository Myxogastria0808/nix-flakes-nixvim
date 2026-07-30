# lsp.nix — Language Server Protocol and language-specific plugin configuration.
# Enables 28 language servers via nvim-lspconfig (NixVim), lean.nvim for Lean 4,
# and cornelis for interactive Agda development.
# r_language_server, julials, and ocamllsp use package = null (external dependencies required).
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
  #   dotls              : Graphviz DOT            (reference: https://github.com/nikeee/dot-language-server)
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
      # package = null: relies on ocaml-lsp-server provided by the project's
      # own opam switch (e.g. BER MetaOCaml's patched compiler-libs, needed
      # to understand `.< >.` bracket syntax and the `code` type). Using
      # nixvim's own nixpkgs-pinned ocaml-lsp-server here would prefix it
      # onto $PATH ahead of the switch's binary and silently shadow it.
      ocamllsp = {
        enable = true;
        package = null;
      };
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
      # Graphviz DOT language server
      dotls.enable = true;
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

  # cornelis
  # reference: https://github.com/isovector/cornelis
  #
  # A modern Agda plugin for Neovim that provides interactive development
  # features similar to agda-mode in Emacs.
  #
  # Keymaps in Agda files (buffer-local, set via FileType autocmd):
  # Prefix "a" + lspsaga-style key for features with LSP equivalents,
  # prefix "a" + mnemonic key for cornelis-specific features.
  #
  # lspsaga-equivalent keymaps:
  # aK                     : show type context (≈ lspsaga K hover)
  # agd                    : go to definition (≈ lspsaga gd)
  # a]d                    : jump to next goal (≈ lspsaga ]d next diagnostic)
  # a[d                    : jump to previous goal (≈ lspsaga [d prev diagnostic)
  #
  # cornelis-specific keymaps:
  # al                     : load / type-check the current file
  # ar                     : refine the current hole
  # ac                     : case split on the variable in the hole
  # aa                     : auto-solve the current hole
  # aG                     : give the expression in the hole
  # a.                     : infer type of the expression in the hole
  # an                     : normalize the expression in the hole
  extraPlugins = [
    pkgs.vimPlugins.cornelis
  ];

  extraPackages = [
    # cornelis binary (Haskell server that communicates with Agda)
    pkgs.cornelis
    # Agda compiler
    pkgs.agda
  ];

  # pkgs.vimPlugins.cornelis ships only Vimscript files (autoload/, ftplugin/, etc.)
  # and has no lua/ directory, so require("cornelis") always fails at runtime.
  # Wrapping in pcall prevents a hard E5113 error that would otherwise terminate
  # init.lua execution before any subsequent configuration code runs.
  extraConfigLua = ''
    local ok, cornelis = pcall(require, "cornelis")
    if ok then cornelis.setup({}) end
  '';

  # Set commentstring for Lean and Agda so Comment.nvim works correctly.
  # Lean line comment: -- comment
  # Lean block comment: /- comment -/
  # Agda line comment: -- comment
  # Agda block comment: {- comment -}
  # ts-context-commentstring has no Lean/Agda parser, so we set it manually.
  autoCmd = [
    {
      event = "FileType";
      pattern = "lean";
      command = "setlocal commentstring=--\\ %s";
    }
    # Buffer-local keymaps for Agda files.
    {
      event = "FileType";
      pattern = "agda";
      callback.__raw = ''
        function()
          local buf = vim.api.nvim_get_current_buf()
          local opts = function(desc)
            return { buffer = buf, noremap = true, silent = true, desc = desc }
          end
          -- lspsaga-equivalent keymaps (a + lspsaga key)
          vim.keymap.set("n", "aK", "<cmd>CornelisTypeContext<CR>", opts("Agda: type context"))
          vim.keymap.set("n", "agd", "<cmd>CornelisGoToDefinition<CR>", opts("Agda: go to definition"))
          vim.keymap.set("n", "a]d", "<cmd>CornelisNextGoal<CR>", opts("Agda: next goal"))
          vim.keymap.set("n", "a[d", "<cmd>CornelisPrevGoal<CR>", opts("Agda: previous goal"))
          -- cornelis-specific keymaps (a + mnemonic)
          vim.keymap.set("n", "al", "<cmd>CornelisLoad<CR>", opts("Agda: load file"))
          vim.keymap.set("n", "ar", "<cmd>CornelisRefine<CR>", opts("Agda: refine hole"))
          vim.keymap.set("n", "ac", "<cmd>CornelisMakeCase<CR>", opts("Agda: case split"))
          vim.keymap.set("n", "aa", "<cmd>CornelisAuto<CR>", opts("Agda: auto-solve"))
          vim.keymap.set("n", "aG", "<cmd>CornelisGive<CR>", opts("Agda: give solution"))
          vim.keymap.set("n", "a.", "<cmd>CornelisTypeContextInfer<CR>", opts("Agda: infer type"))
          vim.keymap.set("n", "an", "<cmd>CornelisNormalize<CR>", opts("Agda: normalize"))
        end
      '';
    }
    {
      event = "FileType";
      pattern = "agda";
      command = "setlocal commentstring=--\\ %s";
    }
  ];
}

