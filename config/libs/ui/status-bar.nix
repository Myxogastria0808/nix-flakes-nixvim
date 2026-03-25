{
  # lualine.nvim
  # reference: https://github.com/nvim-lualine/lualine.nvim
  #
  # Configures the statusline at the bottom of the editor.
  # Statusline content is hidden when a neo-tree window is focused.
  plugins.lualine = {
    enable = true;
    # Hide the statusline in neo-tree windows.
    # This works on a per-window basis: when each window has its own statusline,
    # the neo-tree window simply won't render one.
    # However, this alone is NOT enough when using a global statusline
    # (`laststatus=3`), because all windows share a single statusline.
    # In that case, focusing the neo-tree window would cause the shared
    # statusline to display neo-tree's buffer info (filename, encoding, etc.),
    # which is not useful. See `notNeoTree` below for the complementary fix.
    settings.options.disabled_filetypes.statusline = [ "neo-tree" ];
    settings.sections =
      let
        # A raw Lua function embedded via NixVim's `__raw` escape hatch.
        # It checks `vim.bo.filetype` (the current buffer's filetype) and returns
        # true only when the filetype is NOT "neo-tree" (Lua's `~=` means "not equal").
        #
        # This is passed as `cond` to each lualine component below. The `cond`
        # option controls whether a component is displayed: when it returns false,
        # the component is hidden.
        #
        # Combined with `disabled_filetypes` above, these two mechanisms keep the
        # statusline clean in the file tree area:
        #   - `disabled_filetypes` hides the statusline per-window.
        #   - `notNeoTree` as `cond` hides individual components (filename,
        #     encoding, fileformat, filetype, progress, location) when neo-tree
        #     is focused under a global statusline.
        notNeoTree.__raw = "function() return vim.bo.filetype ~= 'neo-tree' end";
      in
      {
        # left side
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            "__unkeyed-1" = "filename";
            cond = notNeoTree;
          }
          {
            # LSP diagnostics: Error / Warn / Info counts for the current buffer.
            "__unkeyed-1" = "diagnostics";
            sources = [ "nvim_lsp" ];
            sections = [
              "error"
              "warn"
              "info"
            ];
            # Always show the component even when there are zero diagnostics.
            # Without this, lualine hides the section entirely when the file is clean,
            # making it impossible to tell whether diagnostics are working or just absent.
            always_visible = true;
            # Icons for each diagnostic level (Nerd Font required).
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
            };
            # Explicit colors matching tokyonight palette.
            diagnostics_color = {
              error = { fg = "#f7768e"; };
              warn = { fg = "#e0af68"; };
              info = { fg = "#7dcfff"; };
            };
            cond = notNeoTree;
          }
        ];
        # right side
        #
        # lualine_x.__raw = "{}" instead of lualine_x = []
        #
        # NixVim omits empty lists from the generated Lua, so lualine falls back
        # to its built-in defaults ({ "encoding", "fileformat", "filetype" }).
        # Using __raw = "{}" passes an explicit empty Lua table, which overrides
        # the defaults and keeps the section truly empty when no components are set.
        lualine_x = [
          {
            # lsp_status shows the name(s) of LSP servers attached to the current
            # buffer, plus a spinner while the server is indexing or loading.
            # This makes it easy to confirm which servers are active at a glance.
            "__unkeyed-1" = "lsp_status";
            cond = notNeoTree;
          }
        ];
        lualine_y = [
          {
            "__unkeyed-1".__raw "progress";;
            cond = notNeoTree;
          }
        ];
        lualine_z = [
          {
            "__unkeyed-1" = "location";
            cond = notNeoTree;
          }
        ];
      };
  };
}
