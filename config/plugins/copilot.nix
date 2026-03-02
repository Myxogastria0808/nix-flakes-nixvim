{
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = true;
        # show suggestions as you type
        auto_trigger = true;
        keymap = {
          accept = "<Tab>";
          # check next suggestion
          # keybind: Alt + ]
          next = "<A-]>";
          # check previous suggestion
          # keybind: Alt + [
          prev = "<A-[>";
          # cancel suggestion
          # keybind: Ctrl + ]
          dismiss = "<C-]>";
        };
      };
    };
  };
}
