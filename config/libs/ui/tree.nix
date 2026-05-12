# tree.nix — File explorer using neo-tree.nvim + nvim-web-devicons; netrw disabled.
# netrw disabled (loaded_netrw = 1 / loaded_netrwPlugin = 1) to prevent netrw's own
# "Press any key to continue" prompt.  The argdelete guard in extraConfigLua handles
# the remaining case (Neovim ≥ 0.12.2 reading the directory as a regular file).
# neo-tree: left panel (width 30), follows current file, git status symbols,
# open_files_do_not_replace_types guards neo-tree / qf / sagaoutline from file-open overwrites.
# nvim-web-devicons: custom icons for Lean (∀), lean-toolchain (∃), Typst (𝐭), Agda (󱗆),
# Mermaid / .mmd (󰒪), .envrc / .bashrc / .zshrc ($).
{
  # Disable netrw to prevent it from showing "Press any key to continue" when
  # it handles a directory buffer before neo-tree's BufEnter autocmd fires.
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

  # `nvim .` hit-enter guard for Neovim ≥ 0.12.2
  #
  # Problem: without netrw, Neovim reads the directory argument as a regular file,
  # producing error messages that accumulate into a "Press any key to continue" prompt.
  # In Neovim ≥ 0.12.2 the `msg_show.return_prompt` UI event was removed, so noice
  # can no longer auto-dismiss that prompt.
  #
  # Fix: at init.lua time (before Neovim opens the arglist), scan argv() for directories.
  # For each one: remove it from the arglist with :argdelete (so Neovim never reads it)
  # and set buftype=nofile on the pre-created buffer (so rendering the initial window
  # does not trigger a file read either).  When all args were directories, cd into the
  # first one and open neo-tree on VimEnter.
  extraConfigLua = ''
    do
      local dir_args = {}
      for i = 0, vim.fn.argc() - 1 do
        local raw = vim.fn.argv(i)
        local full = vim.fn.fnamemodify(raw, ":p"):gsub("/+$", "")
        if vim.fn.isdirectory(full) == 1 then
          table.insert(dir_args, { raw = raw, full = full })
        end
      end
      if #dir_args > 0 then
        for _, d in ipairs(dir_args) do
          pcall(vim.cmd, "argdelete " .. vim.fn.fnameescape(d.raw))
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

