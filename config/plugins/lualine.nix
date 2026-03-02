{
  plugins.lualine = {
    enable = true;
    # hide a line in the file tree area
    settings.options.disabled_filetypes.statusline = [ "neo-tree" ];
    settings.sections =
      let
        notNeoTree.__raw = "function() return vim.bo.filetype ~= 'neo-tree' end";
      in
      {
        # left side line option
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            "__unkeyed-1" = "filename";
            cond = notNeoTree;
          }
        ];
        # right side line option
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
