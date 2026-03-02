{
  plugins.lsp = {
    enable = true;
    servers = {
      nil_ls = {
        enable = true;
        settings.nix.flake.autoArchive = true;
      };
    };
  };
}
