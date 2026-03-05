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
