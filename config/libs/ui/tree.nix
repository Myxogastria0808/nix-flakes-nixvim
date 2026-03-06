{
  # neo-tree.nvim
  # reference: https://github.com/nvim-neo-tree/neo-tree.nvim
  #
  # File explorer tree shown on the left side of the editor.
  #
  # Keymaps:
  # <leader>e : toggle file tree (Normal)
  plugins.neo-tree = {
    enable = true;
    # update git status asynchronously for better performance
    settings.git_status_async = true;
    settings = {
      close_if_last_window = true;
      filesystem.follow_current_file.enabled = true;
      default_component_configs.git_status = {
        symbols = {
          added = "+";
          modified = "~";
          deleted = "✘";
          renamed = "»";
          untracked = "?";
          ignored = "◌";
          unstaged = "-";
          staged = "✓";
          conflict = "!";
        };
      };
      window = {
        position = "left";
        width = 30;
      };
    };
  };

  # nvim-web-devicons
  # reference: https://github.com/nvim-tree/nvim-web-devicons
  #
  # Provides file-type icons used by neo-tree and other plugins.
  # Custom icons added for Lean, lean-toolchain, .envrc, .bashrc, and .zshrc.
  plugins.web-devicons = {
    enable = true;
    settings.override_by_extension.lean = {
      icon = "∀";
      color = "#3b82f6";
      name = "Lean";
    };
    settings.override_by_filename."lean-toolchain" = {
      icon = "∃";
      color = "#eab308";
      name = "LeanToolchain";
    };
    settings.override_by_filename.".envrc" = {
      icon = "$";
      color = "#f59e0b";
      name = "Envrc";
    };
    settings.override_by_filename.".bashrc" = {
      icon = "$";
      color = "#f59e0b";
      name = "Envrc";
    };
    settings.override_by_filename.".zshrc" = {
      icon = "$";
      color = "#f59e0b";
      name = "Envrc";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }
  ];
}
