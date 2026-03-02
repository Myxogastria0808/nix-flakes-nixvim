{
  plugins.lsp = {
    enable = true;
    servers = {
      # nix
      nil_ls = {
        enable = true;
        settings.nix.flake.autoArchive = true;
      };
    };
  };
}
