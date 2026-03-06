{
  # nvim-lspconfig (via NixVim)
  # reference: https://github.com/neovim/nvim-lspconfig
  #
  # Configures language servers for LSP features (diagnostics, go-to-definition, etc.).
  # Enabled servers:
  #   nil_ls   : Nix                        (reference: https://github.com/oxalica/nil)
  #   marksman : Markdown                   (reference: https://github.com/artempyanykh/marksman)
  #   bashls   : shell scripts              (reference: https://github.com/bash-lsp/bash-language-server)
  #   ts_ls    : TypeScript / JavaScript    (reference: https://github.com/typescript-language-server/typescript-language-server)
  #   rust_analyzer : Rust                 (reference: https://github.com/rust-lang/rust-analyzer)
  #   r_language_server : R               (reference: https://github.com/REditorSupport/languageserver)
  #   ocamllsp          : OCaml           (reference: https://github.com/ocaml/ocaml-lsp)
  #   hls               : Haskell         (reference: https://github.com/haskell/haskell-language-server)
  #   tinymist          : Typst           (reference: https://github.com/Myriad-Dreamin/tinymist)
  #   clangd            : C               (reference: https://clangd.llvm.org)
  #   basedpyright      : Python          (reference: https://github.com/DetachHead/basedpyright)
  #   html              : HTML            (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   cssls             : CSS             (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   jdtls             : Java            (reference: https://github.com/eclipse-jdtls/eclipse.jdt.ls)
  #   julials           : Julia           (reference: https://github.com/julia-vscode/LanguageServer.jl)
  #   gopls             : Go              (reference: https://github.com/golang/tools/tree/master/gopls)
  #   taplo             : TOML           (reference: https://github.com/tamasfe/taplo)
  #   jsonls            : JSON           (reference: https://github.com/hrsh7th/vscode-langservers-extracted)
  #   yamlls            : YAML           (reference: https://github.com/redhat-developer/yaml-language-server)
  plugins.lsp = {
    enable = true;
    servers = {
      # Nix language server
      nil_ls.enable = true;
      # Markdown language server
      marksman.enable = true;
      # shell script language server (sh, bash, zsh)
      bashls = {
        enable = true;
        filetypes = [
          "sh"
          "bash"
          "zsh"
        ];
      };
      # TypeScript / JavaScript language server
      ts_ls.enable = true;
      # R language server
      # package = null: relies on R (with languageserver) provided by the project's R flake
      r_language_server = {
        enable = true;
        package = null;
      };
      # OCaml language server
      ocamllsp.enable = true;
      # Haskell language server
      hls = {
        enable = true;
        installGhc = true;
      };
      # Typst language server
      tinymist.enable = true;
      # C language server
      clangd.enable = true;
      # Python language server
      basedpyright.enable = true;
      # HTML language server
      html.enable = true;
      # CSS language server
      cssls.enable = true;
      # Java language server
      jdtls.enable = true;
      # Julia language server
      # package = null: relies on LanguageServer.jl installed in the Julia environment
      julials = {
        enable = true;
        package = null;
      };
      # Go language server
      gopls.enable = true;
      # TOML language server
      taplo.enable = true;
      # JSON language server (included in vscode-langservers-extracted, same as html/cssls)
      jsonls.enable = true;
      # YAML language server
      yamlls.enable = true;
      # Rust language server
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };

  # lean.nvim
  # reference: https://github.com/Julian/lean.nvim
  #
  # Provides Lean 4 language support with an interactive infoview panel.
  # <LocalLeader> is set to Space.
  #
  # Keymaps in Lean files:
  # <LocalLeader>i         : toggle the infoview open or closed
  # <LocalLeader>p         : pause the current infoview
  # <LocalLeader>r         : restart the Lean server for the current file
  # <LocalLeader>v         : interactively configure infoview view options
  # <LocalLeader>x         : place an infoview pin
  # <LocalLeader>c         : clear all current infoview pins
  # <LocalLeader>dx        : place an infoview diff pin
  # <LocalLeader>dc        : clear current infoview diff pin
  # <LocalLeader>dd        : toggle auto diff pin mode
  # <LocalLeader>dt        : toggle auto diff pin mode without clearing diff pin
  # <LocalLeader><Tab>     : jump into the infoview window
  # <LocalLeader>\         : show what abbreviation produces the symbol under the cursor
  #
  # Keymaps in Infoview windows:
  # <CR> / K               : click a widget or interactive area
  # gK                     : select a widget ("shift+click")
  # <Tab> / J              : jump into a tooltip
  # <Shift-Tab>            : jump out of a tooltip
  # <Esc> / C              : clear all open tooltips
  # gd                     : go-to-definition
  # gD                     : go-to-declaration
  # gy                     : go-to-type
  # <LocalLeader><Tab>     : jump to the lean file from the infoview
  #
  # Register .lean → lean filetype before plugins load.
  # lean.nvim's own ftdetect does not run when the plugin is lazy-loaded, so this
  # ensures FileType lean fires and triggers the lazy loader correctly.
  extraConfigLuaPre = ''
    vim.filetype.add({ extension = { lean = "lean" } })
  '';

  plugins.lean = {
    enable = true;
    lazyLoad.settings.ft = "lean";
    settings = {
      # infoview panel settings
      infoview = {
        height = 10;
        orientation = "horizontal";
        horizontal_position = "bottom";
        indicators = "always";
      };
      # enable the keymaps listed in the header above
      mappings = true;
    };
  };
}
