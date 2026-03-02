{
  globals.mapleader = " ";
  keymaps = [
    # Ctrl+S で保存
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
    # Ctrl+N で neo-tree の開閉
    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle neo-tree";
    }
  ];
}
