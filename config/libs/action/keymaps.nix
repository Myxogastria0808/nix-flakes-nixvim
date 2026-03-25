{
  # Global keymaps and leader keys.
  globals = {
    # set <leader> to space
    mapleader = " ";
    # set <LocalLeader> to space
    maplocalleader = " ";
  };

  opts = {
    # Enable mouse support.
    mouse = "a";
    # Disable ctags: prevent tag file lookup and related errors.
    tags = "";
  };

  # Global keymaps independent of any specific plugin.
  #
  # Keymaps:
  # <C-s>           : save file (Normal / Insert / Visual)
  # <C-LeftMouse>   : open URL under cursor in browser (Normal / Insert / Visual / Terminal)
  # <A-l>           : toggle line wrap (Normal / Insert / Visual)
  # <A-w>           : show word/char count popup (Normal / Insert / Visual)
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
    # Toggle line wrap.
    # keybind: Alt + L
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-l>";
      action = "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>";
      options.desc = "Toggle line wrap";
    }
    # Show word/char count in a popup.
    # In visual mode, shows selected/total counts.
    # keybind: Alt + W
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<A-w>";
      action.__raw = ''
        function()
          local wc = vim.fn.wordcount()
          local msg
          if wc.visual_chars ~= nil then
            msg = wc.visual_words .. '/' .. wc.words .. ' words\n' .. wc.visual_chars .. '/' .. wc.chars .. ' chars'
          else
            msg = wc.words .. ' words\n' .. wc.chars .. ' chars'
          end
          vim.notify(msg, vim.log.levels.INFO, { title = 'Word Count' })
        end
      '';
      options.desc = "Show word/char count popup";
    }
    # Open URL under cursor in browser.
    # keybind: Ctrl + Left Click
    {
      mode = [
        "n"
        "i"
        "v"
        "t"
      ];
      key = "<C-LeftMouse>";
      action = "<LeftMouse><cmd>lua vim.ui.open(vim.fn.expand('<cfile>'))<CR>";
      options.desc = "Open URL under cursor";
    }
  ];
}

