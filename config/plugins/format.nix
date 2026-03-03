{ pkgs, ... }:
{
  extraPackages = [
    # require: markdown
    pkgs.prettier
  ];
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 500;
      };
      formatters_by_ft = {
        # nix
        nix = [ "nixfmt" ];
        # markdown
        markdown = [ "prettier" ];
        # shell script
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        zsh = [ "shfmt" ];
      };
    };
  };
}
