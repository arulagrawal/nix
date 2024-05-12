{ pkgs, config, lib, ... }:
{
  options = {
    neovim.config = lib.mkOption {
      type = lib.types.enum [ "minimal" "full" ];
      default = "full";
    };
  };

  config =
    {
      programs.nixvim = lib.mkMerge [
        {
          enable = true;
          viAlias = true;
          vimAlias = true;
          defaultEditor = true;

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
        }

        (lib.mkIf (config.neovim.config == "full") {
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

            comment.enable = true;
            # Dev
            lsp = {
              enable = true;
              keymaps = {
                diagnostic = {
                  "<leader>j" = "goto_next";
                  "<leader>k" = "goto_prev";
                };
                lspBuf = {
                  K = "hover";
                  gD = "declaration";
                  gd = "definition";
                  gi = "implementation";
                  gt = "type_definition";
                  gr = "references";
                  "<space>rn" = "rename";
                };
              };
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

            cmp = {
              enable = true;
              autoEnableSources = true;
              settings.sources = [
                { name = "nvim_lsp"; }
                { name = "path"; }
                { name = "buffer"; }
                { name = "luasnip"; }
              ];
              settings.mapping = {
                "<C-Space>" = "cmp.mapping.complete()";
                "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                "<C-e>" = "cmp.mapping.close()";
                "<C-f>" = "cmp.mapping.scroll_docs(4)";
                "<CR>" = "cmp.mapping.confirm({ select = true })";
                "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              };
              settings.snippet.expand = ''
                function(args)
                  require('luasnip').lsp_expand(args.body)
                end
              '';
            };
          };
        })
      ];
    };
}
