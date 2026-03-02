{
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = true;
        # show suggestions as you type
        auto_trigger = true;
        keymap = {
          # accept is handled by custom keymap below to avoid <Ignore> insertion
          accept = false;
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

  # Accept copilot suggestion with Tab, fallback to normal Tab.
  # keybind: Tab
  #
  # Why this custom keymap is needed:
  #   copilot.lua's built-in `accept = "<Tab>"` inserts the literal string "<Ignore>"
  #   when no suggestion is visible. Setting `accept = false` disables the built-in
  #   mapping, and this custom keymap provides correct fallback behavior.
  #
  # How the fallback works:
  #   vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
  #     Converts the human-readable "<Tab>" string into Neovim's internal byte sequence.
  #     Args: (str, from_part, do_lt, special)
  #       - from_part = true:  interpret the string as the LHS of a mapping
  #       - do_lt     = false: do NOT convert "<lt>" to literal "<".
  #                            In Vim mappings, "<" starts a special key (e.g. <Tab>, <CR>).
  #                            To type a literal "<" character, you write "<lt>" instead.
  #                            Examples:
  #                              do_lt=true:  "<lt>Tab>" → "<Tab>" (5 literal characters, not a keycode)
  #                              do_lt=false: "<lt>Tab>" → "<lt>" stays unconverted
  #                              do_lt=true:  "<lt>hello" → "<hello" (literal string)
  #                              do_lt=false: "<lt>hello" → "<lt>" stays as-is
  #                            In this case, our input is just "<Tab>" with no "<lt>",
  #                            so do_lt has no effect. We use false to skip the extra processing.
  #       - special   = true:  convert special keys like <Tab>, <CR>, etc.
  #
  #   vim.api.nvim_feedkeys(keys, "n", false)
  #     Feeds the converted keycode into Neovim's input queue.
  #     Args: (keys, mode, escape_ks)
  #       - mode      = "n": noremap mode — does NOT trigger remappings, which prevents
  #                          infinite recursion (Tab -> this keymap -> Tab -> ...)
  #       - escape_ks = false: do not escape keycodes.
  #                            If true, internal key sequence bytes (K_SPECIAL, etc.) in `keys`
  #                            are escaped so that they are not interpreted as special keys but
  #                            instead stored literally (useful when building mapping strings).
  #                            If false, keycodes from nvim_replace_termcodes are fed as-is,
  #                            meaning <Tab> is actually executed as a Tab keypress.
  #                            We want the key to be executed, so we use false.
  keymaps = [
    {
      mode = "i";
      key = "<Tab>";
      action.__raw = ''
        function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          end
        end
      '';
      options.desc = "Accept Copilot suggestion or insert tab";
    }
  ];
}
