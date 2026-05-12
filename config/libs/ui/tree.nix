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

  # Neovim 0.12.2 removed `msg_show.return_prompt` from ui-messages, so noice can no
  # longer auto-dismiss the hit-enter prompt. Without netrw, Neovim tries to read
  # directory buffers as regular files, producing that prompt before VimEnter.
  # Fix: at init time, register a pattern-based BufReadCmd for each directory in argv().
  # Pattern-based BufReadCmd is what Neovim's read code actually checks (buffer-local
  # BufReadCmd is not looked up by the C-level read path). Using `once = true` keeps
  # the autocmd scoped to startup; later directory opens are hijacked by neo-tree's
  # BufEnter autocmd as normal.
  extraConfigLua = ''
    do
      local guard_group = vim.api.nvim_create_augroup("directory_read_guard", { clear = true })
      for i = 0, vim.fn.argc() - 1 do
        local arg = vim.fn.argv(i) --[[@as string]]
        if vim.fn.isdirectory(arg) == 1 then
          vim.api.nvim_create_autocmd("BufReadCmd", {
            group = guard_group,
            pattern = arg,
            once = true,
            callback = function(ev)
              vim.bo[ev.buf].buftype = "nofile"
            end,
          })
        end
      end
    end
  '';

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

