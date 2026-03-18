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
        ];
        # right side
        lualine_x = [
          {
            "__unkeyed-1" = "encoding";
            cond = notNeoTree;
          }
          {
            "__unkeyed-1" = "fileformat";
            cond = notNeoTree;
          }
          {
            "__unkeyed-1" = "filetype";
            cond = notNeoTree;
          }
        ];
        lualine_y = [
          {
            "__unkeyed-1" = "progress";
            cond = notNeoTree;
          }
          {
            # In binary buffers, show only byte count.
            # Otherwise, show total word/char count (or selected count in visual mode).
            "__unkeyed-1".__raw = ''
              function()
                local wc = vim.fn.wordcount()
                if vim.bo.binary then
                  return wc.bytes .. ' bytes'
                end
                if wc.visual_chars ~= nil then
                  return wc.visual_words .. ' words ' .. wc.visual_chars .. ' chars'
                end
                return wc.words .. ' words ' .. wc.chars .. ' chars'
              end
            '';
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
