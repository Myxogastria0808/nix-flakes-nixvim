{ pkgs, ... }:
{
  # telescope.nvim
  # reference: https://github.com/nvim-telescope/telescope.nvim
  #
  # Fuzzy finder for files, text search, buffers, and more.
  # Requires ripgrep for live_grep and fd for find_files.
  #
  # Keymaps (Normal mode):
  # <leader>ff : find files in project
  # <leader>fg : live grep (search text across all files)
  # <leader>fb : find open buffers
  # <leader>fr : recent files
  extraPackages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find files";
      };
      "<leader>fg" = {
        action = "live_grep";
        options.desc = "Live grep";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Find buffers";
      };
      "<leader>fr" = {
        action = "oldfiles";
        options.desc = "Recent files";
      };
    };
  };
}
