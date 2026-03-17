{
  # Global keymaps and leader keys.
  globals = {
    # set <leader> to space
    mapleader = " ";
    # set <LocalLeader> to space
    maplocalleader = " ";
  };

  opts = {
    # Enable mouse support.
    mouse = "a";
    # Disable ctags: prevent tag file lookup and related errors.
    tags = "";
  };

  # Global keymaps independent of any specific plugin.
  #
  # Keymaps:
  # <C-s>           : save file (Normal / Insert / Visual)
  # <C-LeftMouse>   : open URL under cursor in browser (Normal / Insert / Visual / Terminal)
  keymaps = [
    # Save the current file.
    # keybind: Ctrl + S
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "Save file";
    }
    # Open URL under cursor in browser.
    # keybind: Ctrl + Left Click
    {
      mode = [
        "n"
        "i"
        "v"
        "t"
      ];
      key = "<C-LeftMouse>";
      action = "<LeftMouse><cmd>lua vim.ui.open(vim.fn.expand('<cfile>'))<CR>";
      options.desc = "Open URL under cursor";
    }
  ];
}
