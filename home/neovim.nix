{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "auto";
        background = {
          light = "latte";
          dark = "mocha";
        };
        transparent_background = true;
        integrations = {
          nvimtree = true;
          treesitter = true;
        };
      };
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "catppuccin-nvim";
        version = "1.7.0";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "nvim";
          rev = "refs/tags/v1.7.0";
          sha256 = "sha256-yTVou/WArEWygBBs2NFPI9Dm9iSGfwVftKFbOAGl8tk=";
        };
        meta.homepage = "https://github.com/catppuccin/nvim/";
      };
    };

    # Settings
    opts = {
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      number = true;
      clipboard = "unnamedplus";
    };

    # Keymaps
    globals = {
      mapleader = " ";
    };

    plugins = {
      # UI
      lualine.enable = true;
      bufferline.enable = true;
      treesitter.enable = true;
      which-key = {
        enable = true;
        showKeys = true;
      };
      lastplace.enable = true;
      noice = {
        # WARNING: This is considered experimental feature, but provides nice UX
        enable = true;
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          #inc_rename = false;
          #lsp_doc_border = false;
        };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
        extensions = {
          file-browser.enable = true;
        };
      };

      # Dev
      lsp = {
        enable = true;
        servers = {
          marksman.enable = true;
          nil_ls.enable = true;
          gopls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };
    };
  };
}
