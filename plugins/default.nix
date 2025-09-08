{
  config,
  lib,
  pkgs,
  ...
}:
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
    arrow = {
      enable = true;
    };
    barbecue = {
      enable = true;
      settings = {
        lead_custom_section =
          ''
          function()
            return ""
          end
          '';
        show_modified = true;
      };
    };
    better-escape.enable = true;
    bufdelete.enable = true;
   
    # Create Color Code
    ccc.enable = true;
    comment.enable = true;

    # Formatter
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
        executables.lldb = if xcodeEnable then {
          command = "xcrun";
          args = [ "lldb-dap" ];
        } else {
          command = "lldb-dap";
        };
      };
      extensions = {
      };
    };
    dap-ui = {
      enable = true;
      settings = {
        controls = {
          enabled = true;
          element = "repl";
        };
        floating = {
          border = "single";
          mappings.close = [
            "q"
            "esc"
          ];
        };
        icons = {
          collapsed = "";
          expanded = "";
          current_frame = "";
        };
        layouts = [
          {
            elements = [
              {
                id = "repl";
                size = 0.34;
              }
              {
                id = "breakpoints";
                size = 0.33;
              }
              {
                id = "console";
                size = 0.33;
              }
            ];
            position = "bottom";
            size = 10;
          }
        ];
      };
    };
    dressing.enable = true;
    helpview.enable = true;
    hex.enable = true;
    inc-rename = {
      enable = true;
    };
    indent-blankline = {
      enable = true;
      settings = {
        exclude = {
          buftypes = [
            "terminal"
            "quickfix"
            "nofile"
          ];
          filetypes = [
            "TelescopePrompt"
            "TelescopeResults"
            "help"
            "lspinfo"
            "checkhealth"
            "dashboard"
            "nofile"
          ];
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
        standard_widths = [
          2
          4
          8
        ];
      };
    };
    lightline = {
      enable = true;
      settings = {
        active = {
          left = [
            [
              "mode"
              "paste"
            ]
          ];
          right = [
            [ "lineinfo" ]
            [
              "readonly"
              "filetype"
            ]
          ];
        };
        colorscheme = "rosepine_moon";
      };
    };
    lsp = {
      enable = true;
      capabilities = ''
        capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        capabilities.textDocument.completion.completionItem.snippetSupport = true
      '';
      servers = {
        clangd = {
          enable = true;
          filetypes = [
            "c"
            "cpp"
          ];
        };
        emmet_ls = {
          enable = true;
        };
        somesass_ls = {
          enable = true;
          package = null;
        };
        sourcekit = {
          enable = true;
          settings = {
            cmd = if xcodeEnable then [
              "xcrun"
              "sourcekit-lsp"
              # "--compilation-db-search-path"
              # "./build"
            ] else [
              "sourcekit-lsp"
              # "--compilation-db-search-path"
              # "./build"
            ];
            root_markers = [
              "compile_commands.json"
            ];
          };
          extraOptions = {
            single_file_support = true;
          };
        };
        svelte = {
          enable = true;
        };
        nil_ls = {
          enable = true;
          settings = {
            nix.flake = {
              autoArchive = true;
              autoEvalInputs = true;
            };
          };
        };
        lua_ls = {
          enable = true;
          settings = {
            diagnostics = {
              globals = [ "vim" ];
            };
          };
        };
        ts_ls = {
          enable = true;
        };
      };
    };
    lspkind = {
      enable = true;
      settings = {
        mode = "symbol";
        cmp = {
          enable = true;
          max_width = 30;
          ellipsi_char = "…";
          menu = {
            nvim_lsp = "L";
            treesitter = "T";
            nvim_lua = "V";
          };
        };
      };
    };
    luasnip = {
      enable = true;
    };
    markview = {
      enable = false;
    };
    nix.enable = true;
    notify = {
      enable = true;
      settings = {
        max_width = 50;
        minimum_width = 40;
      };
    };
    nvim-autopairs = {
      enable = true;
      settings = {
        disable_filetype = [
          "TelescopePrompt"
          "TelescopeResults"
          "help"
          "lspinfo"
          "checkhealth"
          "dashboard"
        ];
      };
    };
    nvim-tree = {
      enable = true;
      settings = {
        diagnostics.enable = true;
        trash.cmd = "rip";
      };
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
    smart-splits = {
      enable = true;
      settings = {
        at_edge = "stop";
      };
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
                    local bufferTypeIgnored = { "help", "nofile", "dap-repl", "dapui_breakpoints", "dapui_console", "NvimTree" }
                    local bufferType = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
                    if vim.list_contains(bufferTypeIgnored, bufferType) then
                      return "%#IblWhitespace#    "
                    end

                    local firstLine = vim.api.nvim_exec2('echo line("w0")', { output = true }).output
                    local lastLine = vim.api.nvim_exec2('echo line("w$")', { output = true }).output

                    local signText = nil
                    local signHlGroup = nil

                    if segment.sign and segment.sign.wins and segment.sign.wins[args.win].signs and segment.sign.wins[args.win].signs[args.lnum] then
                      local signs = segment.sign.wins[args.win].signs[args.lnum]
                      if table.getn(signs) > 0 then
                        table.sort(signs, function(a, b)
                          return a.priority > b.priority
                        end)
                        signText = signs[1].sign_text
                        signHlGroup = signs[1].sign_hl_group
                      end
                    end

                    if signText == nil then
                      if segment.sign and args.lnum == lastLine then
                        -- local allSigns = segment.sign.wins[args.win].signs
                        local allSigns = vim.fn.sign_getplaced(tostring(vim.fn.bufname(args.buf)), { group = "*" })
                        for line, sign in pairs(allSigns) do
                          if line > lastLine then
                            local signs = table.sort(sign, function(a,b) return a.priority > b.priority end)
                            if table.getn(signs) > 0 then
                              content = " "
                              hlGroup = "%#DiagnosticSignWarn#"
                              -- hlGroup = signs[1].sign_hl_group
                              break
                            end
                          end
                        end
                      elseif segment.sign and args.lnum == firstLine then
                        -- local allSigns = segment.sign.wins[args.win].signs
                        local allSigns = vim.fn.sign_getplaced(tostring(vim.fn.bufname(args.buf)), { group = "*" })
                        for line, sign in pairs(allSigns) do
                          if line < lastLine then
                            local signs = table.sort(sign, function(a,b) return a.priority > b.priority end)
                            if table.getn(signs) > 0 then
                              content = " "
                              hlGroup = "%#DiagnosticSignWarn#"
                              -- hlGroup = signs[1].sign_hl_group
                              break
                            end
                          end
                        end
                      end
                    end
                    
                    local relnum = tostring(args.relnum)
                    local len = string.len(relnum)
                    local padLen = 2 - len
                    local pad = string.rep("0", padLen)
                    local hlGroup
                    local content

                    if signText ~= nil then
                      content = signText
                    elseif content == nil then
                      content = pad .. relnum
                    end

                    if signText ~= nil then
                      hlGroup = "%#" .. signHlGroup .. "#"
                    elseif hlGroup == nil then
                      if args.relnum == 0 then
                        hlGroup = "%#LineNr#"
                      elseif args.relnum > 0 then
                        hlGroup = "%#LineNrAbove#"
                      else
                        hlGroup = "%#LineNrBelow#"
                      end
                    end

                    return hlGroup .. "▏%(" .. content .. "%)▕%#IblWhitespace#%( %)"
                  end
                '';
              }
            ];
            sign = {
              namespace = [ ".*diagnostic/signs" ];
              auto = false;
              wrap = false;
            };
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
      settings.filter.__raw = ''
        function(mapping)
          return mapping.desc and mapping.desc ~= ""
        end
      '';
    };
    yazi = {
      enable = false;
    };
    zen-mode = {
      enable = true;
    };
  };
}
