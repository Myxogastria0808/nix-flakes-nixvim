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
  # <C-s>       : save file          (Normal / Insert / Visual)
  # <leader>e   : toggle file tree   (Normal)
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
    # Toggle the neo-tree file explorer open or closed.
    # keybind: Space -> E
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }
  ];
}
