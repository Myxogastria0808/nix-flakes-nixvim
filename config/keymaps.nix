{
  # Global keymaps independent of any specific plugin.
  #
  # Keymaps:
  # <C-s>       : save file          (Normal / Insert / Visual)
  # <leader>e   : toggle file tree   (Normal)
  globals.mapleader = " ";
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
