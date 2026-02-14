{
  plugins = {
    # neo-tree
    neo-tree = {
      enable = true;
      settings = {
        close_if_last_window = true;
        filesystem.follow_current_file = true;
        window = {
          position = "left";
          width = 30;
        };
      };
    };
    # icon
    web-devicons.enable = true;
    #* lsp *#
    lsp = {
      inlayHints.enable = true;
      servers = {
        nixd.enable = true;
      };
    };
  };
}
