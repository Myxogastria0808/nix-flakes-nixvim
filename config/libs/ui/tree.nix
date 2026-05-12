# tree.nix — File explorer using neo-tree.nvim + nvim-web-devicons; netrw disabled.
# netrw is disabled (loaded_netrw = 1 / loaded_netrwPlugin = 1) so neo-tree handles all directory
# opening (including `nvim .`) without "Press any key to continue" interference.
# neo-tree: left panel (width 30), follows current file, git status symbols,
# open_files_do_not_replace_types guards neo-tree / qf / sagaoutline from file-open overwrites.
# nvim-web-devicons: custom icons for Lean (∀), lean-toolchain (∃), Typst (𝐭), Agda (󱗆),
# Mermaid / .mmd (󰒪), .envrc / .bashrc / .zshrc ($).
{
  # Disable netrw so neo-tree handles all directory opening (including `nvim .`).
  # Without this, netrw activates first and shows "Press any key to continue"
  # before neo-tree's BufEnter hijack can take over.
  globals.loaded_netrw = 1;
  globals.loaded_netrwPlugin = 1;

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
      # Prevent neo-tree / terminal / quickfix windows from being used as the
      # file-open target. When no valid editor window is found neo-tree opens a
      # new split instead of replacing its own panel.
      open_files_do_not_replace_types = [
        "neo-tree"
        "qf"
        "sagaoutline"
      ];
      filesystem.follow_current_file.enabled = true;
      filesystem.filtered_items.visible = true;
      default_component_configs.git_status = {
        symbols = {
          conflict = "!";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          untracked = "?";
          stashed = "\\$";
          modified = "~";
          staged = "✓";
          renamed = "»";
          deleted = "✘";
          added = "+";
          ignored = "◌";
          unstaged = "-";
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
  # Custom icons added for Lean (∀), lean-toolchain (∃), Typst (𝐭), Agda (󱗆),
  # Mermaid / .mmd (󰒪), .envrc/.bashrc/.zshrc ($).
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
    settings.override_by_extension.typ = {
      icon = "𝐭";
      color = "#239dad";
      name = "Typst";
    };
    settings.override_by_extension.agda = {
      icon = "󱗆";
      color = "#3b82f6";
      name = "Agda";
    };
    settings.override_by_extension.mmd = {
      icon = "󰒪";
      color = "#ff3670";
      name = "Mermaid";
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
    # Toggle the neo-tree file explorer panel open or closed.
    # keybind: Space + E
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }
  ];
}

