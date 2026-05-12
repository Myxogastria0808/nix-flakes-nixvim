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
  # longer auto-dismiss the hit-enter prompt that appears when Neovim tries to read a
  # directory argument as a regular file (no netrw BufReadCmd handler exists).
  #
  # Fix strategy: During init.lua (before Neovim processes the arglist), scan argv() for
  # directory arguments and remove them with :argdelete. Neovim never creates the directory
  # buffer, so no file-read error and no hit-enter prompt. A VimEnter autocmd then opens
  # neo-tree for the removed directory and cd's into it so the tree shows the right root.
  # This handles `nvim .`, `nvim ./subdir`, and `nvim /abs/path/to/dir`.
  extraConfigLua = ''
    do
      local dir_args = {}
      for i = 0, vim.fn.argc() - 1 do
        local raw = vim.fn.argv(i)
        local full = vim.fn.fnamemodify(raw, ":p"):gsub("[/\\]+$", "")
        if vim.fn.isdirectory(full) == 1 then
          table.insert(dir_args, { raw = raw, full = full })
        end
      end
      if #dir_args > 0 then
        for _, d in ipairs(dir_args) do
          pcall(vim.cmd, "argdelete " .. vim.fn.fnameescape(d.raw))
          -- Mark the buffer as nofile so Neovim does not attempt to read
          -- the directory as a regular file when it renders the initial window.
          local bufnr = vim.fn.bufnr(d.raw)
          if bufnr ~= -1 then
            vim.bo[bufnr].buftype = "nofile"
          end
        end
        if vim.fn.argc() == 0 then
          local target = dir_args[1].full
          vim.api.nvim_set_current_dir(target)
          vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
              vim.cmd("Neotree toggle")
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

