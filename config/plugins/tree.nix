{
  plugins.neo-tree = {
    enable = true;
    # git status
    settings.git_status_async = true;
    settings = {
      close_if_last_window = true;
      filesystem.follow_current_file.enabled = true;
      # git status
      default_component_configs.git_status = {
        symbols = {
          added = "+";
          modified = "m";
          deleted = "x";
          renamed = "r";
          untracked = "?";
          ignored = "i";
          unstaged = "u";
          staged = "s";
          conflict = "!";
        };
      };
      window = {
        position = "left";
        width = 30;
      };
    };
  };

  # icon
  plugins.web-devicons.enable = true;
}
