# image-chafa.nix — Auto-preview images in the file-open pane using chafa.
# Used by the `default` package (config/default.nix), which targets any
# terminal. For real per-pixel previews on a Kitty Graphics Protocol
# terminal, see image-kitty.nix (used by the `kitty` package instead).
#
# When an image file of a format chafa's loaders support (AVIF, GIF, JPEG,
# JXL, PNG, QOI, SVG, TIFF, WebP, XWD — per `chafa --version`) is opened, a
# BufReadPost autocmd swaps the window to a scratch terminal buffer running
# chafa, rendering it as character art in the same pane normal file contents
# appear in (no floating window).
{ pkgs, ... }:
{
  # chafa — CLI that converts images to terminal-printable character art.
  extraPackages = [ pkgs.chafa ];

  autoCmd = [
    {
      event = "BufReadPost";
      pattern = [
        "*.avif"
        "*.gif"
        "*.jpg"
        "*.jpeg"
        "*.jxl"
        "*.png"
        "*.qoi"
        "*.svg"
        "*.tif"
        "*.tiff"
        "*.webp"
        "*.xwd"
      ];
      callback.__raw = ''
        function(args)
          local buf = args.buf
          local path = vim.api.nvim_buf_get_name(buf)
          local win = vim.api.nvim_get_current_win()

          -- Wipe the raw binary buffer once we swap away from it, so
          -- reopening the same file re-triggers BufReadPost instead of
          -- just switching back to the (still binary) hidden buffer.
          vim.bo[buf].bufhidden = "wipe"

          local preview_buf = vim.api.nvim_create_buf(false, true)
          vim.bo[preview_buf].bufhidden = "wipe"
          vim.api.nvim_win_set_buf(win, preview_buf)

          -- Strip the number/sign/fold gutters from this window before
          -- measuring it. nvim_win_get_width() returns the FULL window
          -- width, gutters included, but the :terminal PTY only gets the
          -- remaining *text* area. The global `number = true` option
          -- (set in ui/utils.nix) alone reserves a 4-column gutter, so
          -- without this the width passed to chafa is 4 columns wider
          -- than what the PTY can actually display: chafa renders a row
          -- that's too long, the PTY wraps the last few cells onto a new
          -- line, and that one extra wrapped line per row repeats down
          -- the whole image — the horizontal banding this is guarding
          -- against.
          vim.wo[win].number = false
          vim.wo[win].relativenumber = false
          vim.wo[win].signcolumn = "no"
          vim.wo[win].foldcolumn = "0"

          local width = vim.api.nvim_win_get_width(win)
          local height = vim.api.nvim_win_get_height(win)

          -- --format symbols/--probe off pin chafa to character-art output
          -- instead of letting it auto-probe the surrounding terminal for
          -- pixel protocols (Kitty, Sixel, iTerm2): the probe targets the
          -- *outer* terminal, but this runs inside a Neovim :terminal
          -- buffer backed by libvterm, which understands none of those
          -- protocols — left on, chafa can stall for its ~5s probe timeout
          -- and then dump raw protocol bytes into the buffer as garbage.
          -- --symbols sextant selects glyphs with 2x3 sub-cells (vs. the
          -- 1x2 of the half-block set), tripling vertical resolution;
          -- -c full forces 24-bit truecolor instead of a guessed,
          -- possibly-downsampled palette.
          vim.fn.jobstart({
            "chafa",
            path,
            "--size",
            width .. "x" .. height,
            "--format",
            "symbols",
            "--symbols",
            "sextant",
            "-c",
            "full",
            "--probe",
            "off",
          }, { term = true })

          -- jobstart(..., {term = true}) renames the buffer to term://...
          -- itself, so the friendlier name has to be applied afterwards.
          pcall(vim.api.nvim_buf_set_name, preview_buf, path .. " [Preview]")

          vim.schedule(function()
            vim.cmd("stopinsert")
          end)
        end
      '';
    }
  ];
}

