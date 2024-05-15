{ pkgs
, config
, lib
, ...
}: {
  options = {
    neovim.config = lib.mkOption {
      type = lib.types.enum [ "minimal" "full" ];
      default = "full";
    };
  };

  config = {
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

        keymaps = [
          {
            mode = [ "n" "v" ];
            key = "<leader>cf";
            action = "<cmd>lua vim.lsp.buf.format()<cr>";
            options = {
              silent = true;
              desc = "Format";
            };
          }
        ];

        plugins = {
          # UI
          lualine.enable = true;
          bufferline.enable = true;
          treesitter = {
            enable = true;
            indent = true;
          };
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
          lsp-format.enable = true;
          lsp = {
            enable = true;
            keymaps = {
              diagnostic = {
                "<leader>j" = "goto_next";
                "<leader>k" = "goto_prev";
                "<leader>d" = "open_float";
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

          cmp-nvim-lsp = { enable = true; }; # lsp
          cmp-buffer = { enable = true; };
          cmp-path = { enable = true; }; # file system paths
          cmp_luasnip = { enable = true; }; # snippets
          cmp-cmdline = { enable = false; }; # autocomplete for cmdline
          cmp = {
            enable = true;
            settings = {
              autoEnableSources = true;
              experimental = { ghost_text = true; };
              performance = {
                debounce = 60;
                fetchingTimeout = 200;
                maxViewEntries = 30;
              };
              snippet = {
                expand = ''
                  function(args)
                    require('luasnip').lsp_expand(args.body)
                  end
                '';
              };
              completion = {
                completeopt = "menu,menuone,noselect";
              };
              formatting = { fields = [ "kind" "abbr" "menu" ]; };
              sources = [
                { name = "nvim_lsp"; }
                { name = "emoji"; }
                {
                  name = "buffer"; # text within current buffer
                  option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                  keywordLength = 3;
                }
                {
                  name = "path"; # file system paths
                  keywordLength = 3;
                }
                {
                  name = "luasnip"; # snippets
                  keywordLength = 3;
                }
              ];

              window = {
                completion = { border = "solid"; };
                documentation = { border = "solid"; };
              };

              mapping = {
                "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                "<C-j>" = "cmp.mapping.select_next_item()";
                "<C-k>" = "cmp.mapping.select_prev_item()";
                "<C-e>" = "cmp.mapping.abort()";
                "<C-b>" = "cmp.mapping.scroll_docs(-4)";
                "<C-f>" = "cmp.mapping.scroll_docs(4)";
                "<C-Space>" = "cmp.mapping.complete()";
                "<CR>" = "cmp.mapping.confirm({ select = true })";
                "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
              };
            };
          };
          luasnip = {
            enable = true;
            extraConfig = {
              enable_autosnippets = true;
              store_selection_keys = "<Tab>";
            };
          };
          conform-nvim = {
            enable = true;
            formatOnSave = {
              lspFallback = true;
              timeoutMs = 500;
            };
            notifyOnError = true;
            formattersByFt = {
              liquidsoap = [ "liquidsoap-prettier" ];
              html = [ [ "prettierd" "prettier" ] ];
              css = [ [ "prettierd" "prettier" ] ];
              javascript = [ [ "prettierd" "prettier" ] ];
              javascriptreact = [ [ "prettierd" "prettier" ] ];
              typescript = [ [ "prettierd" "prettier" ] ];
              typescriptreact = [ [ "prettierd" "prettier" ] ];
              python = [ "black" ];
              lua = [ "stylua" ];
              nix = [ "nixpkgs-fmt" ];
              markdown = [ [ "prettierd" "prettier" ] ];
              yaml = [ "yamllint" "yamlfmt" ];
            };
          };
          none-ls = {
            enable = true;
            enableLspFormat = true;
            updateInInsert = false;
            sources = {
              code_actions = {
                gitsigns.enable = true;
                statix.enable = true;
              };
              diagnostics = {
                statix.enable = true;
                yamllint.enable = true;
              };
              formatting = {
                nixpkgs_fmt.enable = true;
                black = {
                  enable = true;
                  withArgs = ''
                    {
                      extra_args = { "--fast" },
                    }
                  '';
                };
                prettier = {
                  enable = true;
                  disableTsServerFormatter = true;
                  withArgs = ''
                    {
                      extra_args = { "--no-semi", "--single-quote" },
                    }
                  '';
                };
                stylua.enable = true;
                yamlfmt.enable = true;
              };
            };
          };
        };
      })
    ];
  };
}
