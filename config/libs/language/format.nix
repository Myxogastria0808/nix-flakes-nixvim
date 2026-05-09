# format.nix — Format-on-save and async linting.
# conform.nvim: formats on BufWritePre (500 ms timeout, lsp_format fallback) with per-filetype formatters.
# A BufWritePre autocmd also enforces exactly one trailing newline on every save.
# nvim-lint: runs actionlint (GitHub Actions), hadolint (Dockerfile), checkmake (Makefile) asynchronously.
# mermaid-formatter is built from the npm tarball via stdenv.mkDerivation (no runtime deps, dist pre-compiled).
{ pkgs, ... }:
let
  # mermaid-formatter
  # reference: https://github.com/chenyanchen/mermaid-formatter
  #
  # Formatter for Mermaid diagram syntax (.mmd files).
  # The npm tarball ships pre-compiled JS with zero runtime dependencies,
  # so we use stdenv.mkDerivation with makeWrapper instead of buildNpmPackage,
  # avoiding the need for a vendored package-lock.json and npmDepsHash.
  #
  # mermaidfmt reads from stdin and writes formatted output to stdout when
  # invoked without arguments, which is the mode conform.nvim uses.
  mermaidFormatter = pkgs.stdenv.mkDerivation {
    pname = "mermaid-formatter";
    version = "0.3.0";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/mermaid-formatter/-/mermaid-formatter-0.3.0.tgz";
      hash = "sha256-PKv0cFTu7lr8U5raoGhF/xbjEx1cQEvZ9xhSY51jFHQ=";
    };
    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/bin $out/lib/node_modules/mermaid-formatter
      cp -r . $out/lib/node_modules/mermaid-formatter/
      makeWrapper ${pkgs.nodejs}/bin/node $out/bin/mermaidfmt \
        --add-flags "$out/lib/node_modules/mermaid-formatter/dist/cli.js"
    '';
    meta = {
      description = "A formatter for Mermaid diagram syntax";
      homepage = "https://github.com/chenyanchen/mermaid-formatter";
      mainProgram = "mermaidfmt";
    };
  };
in
{
  extraPackages = [
    # required by Astro formatter
    pkgs.prettier
    # required by JSON / YAML / JS / TS / HTML / CSS / Markdown formatter
    pkgs.oxfmt
    # required by shell script formatter
    pkgs.shfmt
    # required by R formatter
    pkgs.air
    # required by OCaml formatter
    pkgs.ocamlPackages.ocamlformat
    # required by Haskell formatter
    pkgs.haskellPackages.fourmolu
    # required by Typst formatter
    pkgs.typstyle
    # required by C formatter (clang-format)
    pkgs.clang-tools
    # required by Java formatter
    pkgs.google-java-format
    # required by Go formatter
    pkgs.gofumpt
    # required by TOML formatter
    pkgs.taplo
    # required by Python formatter
    pkgs.ruff
    # required by GitHub Actions linter
    pkgs.actionlint
    # required by Elm formatter
    pkgs.elmPackages.elm-format
    # required by Dockerfile linter
    pkgs.hadolint
    # required by Makefile formatter
    pkgs.mbake
    # required by Makefile linter
    pkgs.checkmake
    # required by LaTeX formatter (latexindent) and TeX compilation toolchain
    pkgs.texliveFull
    # required by Mermaid formatter
    mermaidFormatter
  ];

  # conform-nvim
  # reference: https://github.com/stevearc/conform.nvim
  #
  # Formats files automatically on save using per-filetype formatters.
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 500;
      };
      formatters_by_ft = {
        # nix formatter
        nix = [ "nixfmt" ];
        # Markdown formatter
        markdown = [ "oxfmt" ];
        # shell script formatter (sh, bash, zsh)
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        zsh = [ "shfmt" ];
        # R formatter
        r = [ "air" ];
        # OCaml formatter
        ocaml = [ "ocamlformat" ];
        # Haskell formatter
        haskell = [ "fourmolu" ];
        # Typst formatter
        typst = [ "typstyle" ];
        # C formatter
        c = [ "clang_format" ];
        # Python formatter
        python = [ "ruff_format" ];
        # HTML formatter
        html = [ "oxfmt" ];
        # CSS formatter
        css = [ "oxfmt" ];
        # Java formatter
        java = [ "google-java-format" ];
        # Go formatter
        go = [ "gofumpt" ];
        # TOML formatter
        toml = [ "taplo" ];
        # JSON / JSONC formatter
        json = [ "oxfmt" ];
        jsonc = [ "oxfmt" ];
        # YAML formatter
        yaml = [ "oxfmt" ];
        # GitHub Actions workflow formatter (yaml.github filetype)
        "yaml.github" = [ "oxfmt" ];
        # Elm formatter
        elm = [ "elm_format" ];
        # Rust formatter
        rust = [ "rustfmt" ];
        # JavaScript / JSX / TypeScript / TSX formatter
        javascript = [ "oxfmt" ];
        javascriptreact = [ "oxfmt" ];
        typescript = [ "oxfmt" ];
        typescriptreact = [ "oxfmt" ];
        # MDX formatter
        mdx = [ "oxfmt" ];
        # Astro formatter (oxfmt does not support Astro yet)
        astro = [ "prettier" ];
        # LaTeX formatter
        tex = [ "latexindent" ];
        # Makefile formatter
        make = [ "bake" ];
        # Mermaid formatter
        mermaid = [ "mermaidfmt" ];
      };
      # mermaidfmt is not a built-in conform formatter, so define it here.
      # It reads from stdin and writes formatted output to stdout.
      formatters.mermaidfmt = {
        command = "mermaidfmt";
        stdin = true;
      };
    };
  };

  # Ensure every file always ends with a trailing newline on save.
  #
  # conform's format_on_save hooks BufWritePre first; this autocmd is
  # registered via extraConfigLua which runs after all plugin setup, so it
  # fires after conform and gets the final say on buffer content.
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        local buf = vim.fn.bufnr()
        local last = vim.fn.line("$")
        -- Remove extra trailing blank lines, keeping at most one
        while last > 1 and vim.fn.getline(last) == "" and vim.fn.getline(last - 1) == "" do
          vim.fn.deletebufline(buf, last)
          last = last - 1
        end
        -- Ensure exactly one trailing newline
        if vim.fn.getline(last) ~= "" then
          vim.fn.append(last, "")
        end
      end,
    })
  '';

  # nvim-lint
  # reference: https://github.com/mfussenegger/nvim-lint
  #
  # Runs linters per filetype as an async linting engine.
  # Enabled linters:
  #   actionlint : GitHub Actions workflows  (reference: https://github.com/rhysd/actionlint)
  #   hadolint   : Dockerfile                (reference: https://github.com/hadolint/hadolint)
  #   checkmake  : Makefile                  (reference: https://github.com/mrtazz/checkmake)
  plugins.lint = {
    enable = true;
    lintersByFt = {
      # GitHub Actions workflow linter
      "yaml.github" = [ "actionlint" ];
      # Dockerfile linter
      dockerfile = [ "hadolint" ];
      # Makefile linter
      make = [ "checkmake" ];
    };
  };
}

