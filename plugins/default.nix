{
  imports = [
    ./cmp.nix
    ./extraPlugins.nix
    ./telescope.nix
  ];

  programs.nixvim.plugins = {
    auto-session = {
      enable = true;
    };
    barbecue = {
      enable = true;
    };
    better-escape.enable = true;
    conform-nvim = {
      enable = true;
      settings = {
        lsp_format = "fallback";
        formatters_by_ft = {
          swift = [ "swift_format" ];
        };
        formatters = {
          swift_format = {
            command = "xcrun";
            prepend_args = "swift-format";
          };
        };
      };
    };
    comment = {
      enable = true;
    };
    dashboard = {
      enable = true;
      settings = {
        theme = "hyper";
        config = {
          week_header.enable = false;
          header = [
            "hello"
          ];
          shortcut = null;
          footer = null;
        };
      };
    };
    dap = {
      enable = true;
      adapters = {
        executables.lldb = {
          command = "xcrun";
          args = [ "lldb-dap" ];
        };
      };
      configurations = {
        # swift = [{
        #   request = "launch";
        #   type = "lldb";
        # }];
      };
      extensions = {
        dap-ui.enable = true;
      };
    };
    helpview.enable = true;
    hex.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        exclude = {
          buftypes = [ "terminal" "quickfix" ];
          filetypes = [ "TelescopePrompt" "TelescopeResults" "help" "lspinfo" "checkhealth" "dashboard" ];
        };
      };
    };
    indent-o-matic = {
      enable = true;
      settings = {
        standard_widths = [ 2 4 8 ];
      };
    };
    lightline = {
      enable = true;
      settings = {
        active = {
          left = [
            [ "mode" "paste" ]
          ];
          right = [
            [ "lineinfo" ]
            [ "readonly" "filetype" ]
          ];
        };
        colorscheme = "rosepine_moon";
      };
    };
    lsp = {
      enable = true;
      capabilities = ''
          capabilities.workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true
            }
          }
      '';
      servers = {
        sourcekit = {
          enable = true;
          cmd = [ "xcrun" "sourcekit-lsp" ];
          extraOptions = {
            single_file_support = true;
          };
        };
        nil-ls.enable = true;
        lua-ls = {
          enable = true;
          settings = {
            diagnostics = {
              globals = [ "vim" ];
            };
          };
        };
      };
    };
    lspkind = {
      enable = true;
      mode = "symbol";
      cmp = {
        enable = true;
        maxWidth = 30;
        ellipsisChar = "…";
        menu = {
          nvim_lsp = "[LSP]";
          treesitter = "[TST]";
          nvim_lua = "[VIM]";
        };
      };
    };
    lspsaga = {
      enable = true;
      lightbulb = {
        enable = false;
      };
    };
    markview = {
      enable = true;
    };
    neo-tree = {
      enable = true;
    };
    nix.enable = true;
    notify = {
      enable = true;
    };
    nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [ "TelescopePrompt" "TelescopeResults" "help" "lspinfo" "checkhealth" "dashboard" ];
      };
    };
    otter = {
      enable = true;
    };
    sandwich = {
      enable = true;
    };
    sleuth = {
      enable = true;
    };
    sniprun = {
      enable = true;
      settings = {
        display = [
          "NvimNotify"
          "VirtualTextOk"
        ];
        inline_messages = true;
        interpreter_options = {
          Generic = {
            swift_config = {
              supported_filetypes = [ "swift" ];
              extension = ".swift";
              interpreter = "swift run";

              boilerplate_pre = "import Foundation";
            };
          };
        };
        live_mode_toggle = "enable";
        selected_interpreters = [ "Generic" ];
      };
    };
    statuscol = {
      enable = true;
      settings = {
        relculright = true;
        # TODO: add click handlers
        segments = [
          {
            text = [
              " "
              {
                __raw = ''
                  require('statuscol.builtin').lnumfunc
                '';
              }
              " "
            ];
          }
        ];
      };
    };
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
      };
    };
    twilight = {
      enable = true;
      settings = {
        dimming = { alpha = 0.6; };
      };
    };
    which-key = {
      enable = true;
    };
    wilder = {
      enable = false;
      modes = [ ":" "/" "?" ];
    };
    yazi = {
      enable = false;
    };
    zen-mode = {
      enable = true;
    };
  };
}
