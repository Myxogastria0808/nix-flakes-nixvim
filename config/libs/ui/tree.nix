# tree.nix — File explorer using neo-tree.nvim + nvim-web-devicons; netrw disabled.
# netrw disabled (loaded_netrw = 1 / loaded_netrwPlugin = 1) to prevent netrw's own
# "Press any key to continue" prompt.  The two-phase guard in extraConfigLua handles
# the remaining case (Neovim ≥ 0.12.2 reading the directory as a regular file):
#   Phase 1 (init.lua): set buftype=nofile on the pre-created directory buffer to block
#   the file-read that generates error messages.  argdelete is intentionally deferred.
#   Phase 2 (VimEnter): run argdelete so alpha-nvim's earlier VimEnter still sees
#   argc() > 0 and skips the startup dashboard (prevents a brief flash), then cd and
#   open neo-tree.
# neo-tree: left panel (width 30), follows current file, git status symbols,
# open_files_do_not_replace_types guards neo-tree / qf / sagaoutline from file-open overwrites.
# nvim-web-devicons: custom icons for Lean (∀), lean-toolchain (∃), Typst (𝐭), Agda (󱗆),
# Mermaid / .mmd (󰒪), Graphviz / .dot (󱁉), .envrc / .bashrc / .zshrc ($).
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
  # Mermaid / .mmd (󰒪), Graphviz / .dot (󱁉), .envrc/.bashrc/.zshrc ($).
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
    settings.override_by_extension.dot = {
      icon = "󱁉";
      color = "#a5b4fc";
      name = "Graphviz";
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
  # Fix (two-phase):
  #   Phase 1 — init.lua time: scan argv() for directories and set buftype=nofile on
  #   each pre-created buffer so that rendering the initial window does not trigger a
  #   file read.  :argdelete is intentionally deferred to Phase 2 so that alpha-nvim's
  #   VimEnter autocmd (registered earlier, fires first) still sees argc() > 0 and
  #   skips its dashboard — preventing the brief flash of the startup screen.
  #
  #   Phase 2 — VimEnter: remove each directory from the arglist with :argdelete, then
  #   if argc() is now 0 (all args were directories), cd into the first directory and
  #   open neo-tree.  Because our VimEnter is registered after alpha's, it fires second,
  #   so alpha has already decided not to show the dashboard before argdelete runs.
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
        -- Phase 1: block the file-read that would produce error messages.
        for _, d in ipairs(dir_args) do
          local bufnr = vim.fn.bufnr(d.raw)
          if bufnr ~= -1 then
            vim.bo[bufnr].buftype = "nofile"
          end
        end
        -- Phase 2: defer argdelete until VimEnter so alpha-nvim's earlier VimEnter
        -- still sees argc() > 0 and skips the dashboard (avoids a brief flash).
        vim.api.nvim_create_autocmd("VimEnter", {
          once = true,
          callback = function()
            for _, d in ipairs(dir_args) do
              pcall(vim.cmd, "argdelete " .. vim.fn.fnameescape(d.raw))
            end
            if vim.fn.argc() == 0 then
              vim.api.nvim_set_current_dir(dir_args[1].full)
              vim.cmd("Neotree toggle")
            end
          end,
        })
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

