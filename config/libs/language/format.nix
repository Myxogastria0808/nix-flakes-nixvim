{ pkgs, ... }:
{
  extraPackages = [
    # required by markdown formatter
    pkgs.prettier
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
        # markdown formatter
        markdown = [ "prettier" ];
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
        # HTML / CSS formatter
        html = [ "prettier" ];
        css = [ "prettier" ];
        # Java formatter
        java = [ "google_java_format" ];
        # Go formatter
        go = [ "gofumpt" ];
        # TOML formatter
        toml = [ "taplo" ];
        # JSON formatter
        json = [ "prettier" ];
        # YAML formatter
        yaml = [ "prettier" ];
        # GitHub Actions workflow formatter
        "yaml.github" = [ "prettier" ];
        # Elm formatter
        elm = [ "elm_format" ];
        # Rust formatter
        rust = [ "rustfmt" ];
        # TypeScript / JavaScript formatter
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        # Astro formatter
        astro = [ "prettier" ];
        # Makefile formatter
        make = [ "bake" ];
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
        local last = vim.fn.line("$")
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
