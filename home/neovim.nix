{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    neovim.full = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    programs.nvf = {
      enable = true;
      enableManpages = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        useSystemClipboard = true;
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };

        luaConfigRC = {
          "opts" = lib.strings.concatLines [
            "vim.opt.smartindent = true"
            "vim.opt.ignorecase = true"
            "vim.opt.smartcase = true"
          ];
        };

        extraPlugins = with pkgs.vimPlugins; {
          remember = {
            package = remember-nvim;
            setup = "require('remember')";
          };
        };

        spellcheck = {
          enable = config.neovim.full;
        };

        lsp = {
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = false;
          lspsaga.enable = config.neovim.full;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = config.neovim.full;
          lsplines.enable = false;
          nvim-docs-view.enable = config.neovim.full;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix.enable = true;
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = config.neovim.full;
          clang.enable = config.neovim.full;
          css.enable = config.neovim.full;
          html.enable = config.neovim.full;
          sql.enable = config.neovim.full;
          java.enable = config.neovim.full;
          kotlin.enable = config.neovim.full;
          ts.enable = config.neovim.full;
          go.enable = config.neovim.full;
          lua.enable = config.neovim.full;
          # zig.enable = config.neovim.full;
          python.enable = config.neovim.full;
          # typst.enable = config.neovim.full;
          rust = {
            enable = config.neovim.full;
            crates.enable = config.neovim.full;
          };

          # Language modules that are not as common.
          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;

          tailwind.enable = false;
          svelte.enable = false;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = config.neovim.full;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = false;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = config.neovim.full;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = config.neovim.full;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = config.neovim.full;
          surround.enable = config.neovim.full;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        # notes = {
        #   obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
        #   neorg.enable = false;
        #   orgmode.enable = false;
        #   mind-nvim.enable = config.neovim.full;
        #   todo-comments.enable = true;
        # };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = false;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          # breadcrumbs = {
          #   enable = config.neovim.full;
          #   navbuddy.enable = config.neovim.full;
          # };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        # assistant = {
        #   chatgpt.enable = false;
        #   copilot = {
        #     enable = false;
        #     cmp.enable = config.neovim.full;
        #   };
        # };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}
