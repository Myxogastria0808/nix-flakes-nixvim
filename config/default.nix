{
  imports = [
    # ui
    ./libs/ui/theme.nix
    ./libs/ui/tree.nix
    ./libs/ui/bar.nix
    ./libs/ui/tab.nix
    ./libs/ui/gitsigns.nix
    ./libs/ui/utils.nix
    ./libs/ui/dashboard.nix
    # language
    ./libs/language/lsp.nix
    ./libs/language/format.nix
    ./libs/language/treesitter.nix
    # action
    ./libs/action/copilot.nix
    ./libs/action/completion.nix
    ./libs/action/commentout.nix
    ./libs/action/utils.nix
    ./libs/action/keymaps.nix
  ];
}
