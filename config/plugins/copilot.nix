{
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = true;
        auto_trigger = true;
        keymap = {
          accept = "<Tab>";
          next = "<A-]>";
          prev = "<A-[>";
          dismiss = "<C-]>";
        };
      };
      panel.enabled = false;
    };
  };
}
