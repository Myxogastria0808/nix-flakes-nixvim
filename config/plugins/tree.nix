{
  plugins.neo-tree = {
    enable = true;
    settings = {
      close_if_last_window = true;
      filesystem.follow_current_file.enabled = true;
      window = {
        position = "left";
        width = 30;
      };
    };
  };

  # icon
  plugins.web-devicons.enable = true;
}
