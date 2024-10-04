{ config, lib, pkgs, ... }:
let
  xcodeEnable = config.mixvim.xcode.enable;
in
{
  imports = [
    ./cmp.nix
    ./extraPlugins.nix
    ./telescope.nix
  ];

  plugins = {
    auto-session = {
      enable = true;
    };
    barbecue = {
      enable = true;
    };
    better-escape.enable = true;
    bufdelete.enable = true;
    ccc.enable = true;
    comment.enable = true;
    conform-nvim = {
      enable = true;
      settings = {
        lsp_format = "fallback";
        formatters_by_ft = {
          swift = [ "swift_format" ];
          nix = [ "nixfmt" ];
        };
        formatters = {
          swift_format = {
            command = "xcrun";
            prepend_args = "swift-format";
          };
          nixfmt = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
          };
        };
      };
      luaConfig.post = ''
      vim.api.nvim_create_user_command(
        "Format",
        function(args)
          require("conform").format({ bufnr = args.buf })
        end,
        {}
      )
      '';
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
        executables.lldb = (lib.mkIf xcodeEnable {
          command = "xcrun";
          args = [ "lldb-dap" ];
        });
      };
      extensions = {
        dap-ui = {
          enable = true;
          controls = {
            enabled = true;
            element = "repl";
          };
          floating = {
            border = "single";
            mappings.close = [ "q" "esc" ];
          };
          icons = {
            collapsed = "";
            expanded = "";
            current_frame = "";
          };
          layouts = [
            {
              elements = [
                { id = "repl"; size = 0.34; }
                { id = "breakpoints"; size = 0.33; }
                { id = "console"; size = 0.33; }
              ];
              position = "bottom";
              size = 10;
            }
          ];
        };
      };
    };
    helpview.enable = true;
    hex.enable = true;
    inc-rename = {
      enable = true;
    };
    indent-blankline = {
      enable = true;
      settings = {
        exclude = {
          buftypes = [ "terminal" "quickfix" ];
          filetypes = [ "TelescopePrompt" "TelescopeResults" "help" "lspinfo" "checkhealth" "dashboard" ];
        };
      };
      luaConfig.post = ''
      local hooks = require("ibl.hooks")
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_tab_indent_level
      )
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )
      '';
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
        sourcekit = (lib.mkIf xcodeEnable {
          enable = true;
          cmd = [ "xcrun" "sourcekit-lsp" ];
          extraOptions = {
            single_file_support = true;
          };
        });
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
    luasnip = {
      enable = true;
      fromSnipmate = [
        {
          paths = ./luasnip/swift.snippets;
          include = [ "swift" ];
        }
      ];
    };
    markview = {
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
    nvim-tree = {
      enable = true;
      diagnostics.enable = true;
      trash.cmd = "rip";
    };
    otter = {
      enable = false;
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
        segments = [
          {
            text = [
              {
                __raw = ''
                function(args, segment)
                  local bufferTypeIgnored = { "help", "nofile" }
                  local bufferType = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
                  if vim.list_contains(bufferTypeIgnored, bufferType) then
                    return "%#IblWhitespace#%   "
                  end

                -- if segment.sign and segment.sign.wins[args.win].signs[args.lnum] then
                --   vim.notify(segment.sign.wins[args.win].signs[args.lnum])
                --   return "AAA"
                -- end
                
                local relnum = tostring(args.relnum)
                local len = string.len(relnum)
                local padLen = 2 - len
                local pad = string.rep(" ", padLen)
                local hlGroup 
                
                if args.relnum == 0 then
                  hlGroup = "%#LineNr#%"
                elseif args.relnum > 0 then
                  hlGroup = "%#LineNrAbove#%"
                else
                  hlGroup = "%#LineNrBelow#%"
                end

                -- return " " .. require('statuscol.builtin').lnumfunc(args, segment) .. " %#LineNrAbove#% ▏ "
                return " " .. pad .. relnum .. " %#LineNrAbove#% ▏ "
                end
                '';
              }
            ];
            # sign = {
            #   name = [ ".*" ];
            #   auto = false;
            #   wrap = false;
            # };
          }
        ];
        clickhandlers = {
          Lnum = "require('statuscol.builtin').lnum_click";
          FoldClose = "require('statuscol.builtin').foldclose_click";
          FoldOpen = "require('statuscol.builtin').foldopen_click";
          FoldOther = "require('statuscol.builtin').foldother_click";
          DapBreakpointRejected = "require('statuscol.builtin').toggle_breakpoint";
          DapBreakpoint = "require('statuscol.builtin').toggle_breakpoint";
          DapBreakpointCondition = "require('statuscol.builtin').toggle_breakpoint";
          "diagnostic/signs" = "require('statuscol.builtin').diagnostic_click";
          gitsigns = "require('statuscol.builtin').gitsigns_click";
        };
      };
    };
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
      };
    };
    web-devicons.enable = true;
    which-key = {
      enable = true;
    };
    yazi = {
      enable = false;
    };
    zen-mode = {
      enable = true;
    };
  };
}
