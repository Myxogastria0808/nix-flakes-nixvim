# image-preview.nix — Auto-preview images in the file-open pane using chafa.
# When an image file of a format chafa's loaders support (AVIF, GIF, JPEG,
# JXL, PNG, QOI, SVG, TIFF, WebP, XWD — per `chafa --version`) is opened, a
# BufReadPost autocmd swaps the window to a scratch terminal buffer running
# chafa, rendering it as character art in the same pane normal file contents
# appear in (no floating window).
#
# --format symbols/--probe off pin chafa to character-art output instead of
# letting it auto-probe the surrounding terminal for pixel protocols (Kitty,
# Sixel, iTerm2): the probe targets the *outer* terminal, but this runs
# inside a Neovim :terminal buffer backed by libvterm, which understands
# none of those protocols — left on, chafa can stall for its ~5s probe
# timeout and then dump raw protocol bytes into the buffer as garbage.
# --symbols sextant selects glyphs with 2x3 sub-cells (vs. the 1x2 of the
# default half-block set), tripling vertical resolution; -c full forces
# 24-bit truecolor instead of a guessed, possibly-downsampled palette.
{ pkgs, ... }:
{
  # chafa — CLI that converts images to terminal-printable ANSI art.
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

          local width = vim.api.nvim_win_get_width(win)
          local height = vim.api.nvim_win_get_height(win)

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
