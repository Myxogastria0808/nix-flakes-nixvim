{
  globals.mapleader = " ";
  keymaps = [
    # Save file
    # keybind: Ctrl+S
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
    # Open / Close file tree
    # keybind: Space -> E
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }
  ];
}
