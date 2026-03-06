{
  # Global keymaps and leader keys.
  globals = {
    # set <leader> to space
    mapleader = " ";
    # set <LocalLeader> to space
    maplocalleader = " ";
  };

  # Global keymaps independent of any specific plugin.
  #
  # Keymaps:
  # <C-s> : save file (Normal / Insert / Visual)
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
  ];
}
