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
    # required by Python formatter
    pkgs.ruff
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
        # Rust formatter
        rust = [ "rustfmt" ];
        # TypeScript / JavaScript formatter
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
      };
    };
  };
}
