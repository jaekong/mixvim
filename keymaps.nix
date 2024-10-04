{ config, lib, ... }:
let
  genericModes = config.mixvim.genericModes;
  commandModes = config.mixvim.commandModes;
  xcodeEnable = config.mixvim.xcode.enable;
  # system = config.mixvim.system;
in
{
  keymaps = lib.mkMerge [
    [
      {
        key = "w";
        options.desc = "Move to the Next Word";
        action = "<Plug>CamelCaseMotion_w";
        mode = genericModes;
      }
      {
        key = "b";
        options.desc = "Move to the Previous Word";
        action = "<Plug>CamelCaseMotion_b";
        mode = genericModes;
      }
      {
        key = "e";
        options.desc = "Move to the End of the Word";
        action = "<Plug>CamelCaseMotion_e";
        mode = genericModes;
      }
      {
        key = "ge";
        options.desc = "Move to the End of the Previous Word";
        action = "<Plug>CamelCaseMotion_ge";
        mode = genericModes;
      }
      {
        key = "s";
        action = "<nop>";
        mode = genericModes;
      }
      {
        key = "q";
        options.desc = "Close window";
        action = "<cmd>:q<cr>";
        mode = ["n" "v"];
      }
      {
        key = "U";
        action = "<cmd>redo<cr>";
        mode = genericModes;
      }
      {
        key = "V";
        action.__raw = ''
        function()
          local mode = vim.api.nvim_get_mode()["mode"]
          if mode == "v" or mode == "V" then
            vim.api.nvim_feedkeys("j", "v", false);
          else
            vim.api.nvim_feedkeys("V", "n", false);
          end
        end
        '';
        mode = genericModes;
      }
      {
        key = "K";
        options.desc = "LSP Description";
        action.__raw = "require('hover').hover";
        mode = genericModes;
      }
      {
        key = "<Tab>";
        action.__raw = ''
        function()
          local col = vim.fn.col(".") - 1
          local line = vim.fn.getline(".")
          local trimmedLine = string.gsub(line, "%s+", "")

          if line == "" then
            vim.g.tabOverride = false
          end

          if (trimmedLine == "") and (vim.g.tabOverride == nil or not vim.g.tabOverride) then
            vim.g.tabOverride = true
            local escKeycode = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
            vim.api.nvim_feedkeys(escKeycode, "n", false)
            vim.api.nvim_feedkeys("cc", "n", false)

            vim.defer_fn(function()
              vim.api.nvim_create_autocmd({"InsertLeave", "InsertCharPre"}, {
                callback = function()
                  vim.g.tabOverride = false
                end,
                once = true
              })
              end, 10)
          else
            vim.api.nvim_feedkeys("\t", "n", false)
          end
        end
        '';
        mode = "i";
      }

      {
        key = "<leader>?";
        options.desc = "Show Keymaps";
        action.__raw = "function()require('which-key').show({ global = true })end";
        mode = genericModes;
      }

      {
        key = "<leader>D";
        options.desc = "Show DAP UI";
        action.__raw = "require('dapui').toggle";
        mode = genericModes;
      }

      {
        key = "\\";
        options.desc = "Toggle File Browser";
        action = "<cmd>NvimTreeToggle<cr>";
        mode = genericModes;
      }
      {
        key = "|";
        options.desc = "Focus on File Browser";
        action = "<cmd>NvimTreeOpen<cr>";
        mode = genericModes;
      }

      {
        key = "<A-h>";
        action.__raw = "require('smart-splits').resize_left";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<A-j>";
        action.__raw = "require('smart-splits').resize_down";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<A-k>";
        action.__raw = "require('smart-splits').resize_up";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<A-l>";
        action.__raw = "require('smart-splits').resize_right";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }

      {
        key = "<C-h>";
        action.__raw = "require('smart-splits').move_cursor_left";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<C-j>";
        action.__raw = "require('smart-splits').move_cursor_down";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<C-k>";
        action.__raw = "require('smart-splits').move_cursor_up";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<C-l>";
        action.__raw = "require('smart-splits').move_cursor_right";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<D-d>";
        action = "<Cmd>rightb:vsplit<CR>";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }
      {
        key = "<D-S-d>";
        action = "<Cmd>rightb:split<CR>";
        mode = genericModes ++ [ "i" ];
        options.nowait = true;
      }

      # macOS Style Keybind
      # Option + up / down
      {
        key = "<A-up>";
        action = "{";
        mode = genericModes;
      }
      {
        key = "<A-up>";
        action = "<esc>{i";
        mode = "i";
      }
      {
        key = "<A-down>";
        action = "}";
        mode = genericModes;
      }
      {
        key = "<A-down>";
        action = "<esc>}i";
        mode = "i";
      }

      # Cmd + up / down
      {
        key = "<D-up>";
        action = "gg";
        mode = genericModes;
      }
      {
        key = "<D-up>";
        action = "<esc>ggi";
        mode = "i";
      }
      {
        key = "<D-down>";
        action = "G";
        mode = genericModes;
      }
      {
        key = "<D-down>";
        action = "<esc>Gi";
        mode = "i";
      }

      # Cmd + backspace
      {
        key = "<D-backspace>";
        action.__raw = "function()vim.g.if_is_at_start('norm! d0', 'norm! d^')end";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-backspace>";
        action = ''&cedit.'d0'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }

      # Option + backspace
      {
        key = "<A-backspace>";
        action.__raw = ''function()vim.cmd [[execute "norm! d\<Plug>CamelCaseMotion_b"]]end'';
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<A-backspace>";
        action = ''&cedit.'db'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }

      # Cmd + left / right
      {
        key = "<D-left>";
        action.__raw = "function()vim.g.if_is_at_start('norm! 0', 'norm! ^')end";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-left>";
        action = ''&cedit.'0'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }
      {
        key = "<D-right>";
        action.__raw = "function()vim.cmd('norm! $l')end";
        mode = genericModes ++ commandModes ++ [ "i" ];
      }
      {
        key = "<D-right>";
        action = ''&cedit.'$'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }

      # Option + left / right
      {
        key = "<A-left>";
        action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_b"]]end'';
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<A-left>";
        action = ''&cedit.'b'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }
      {
        key = "<A-right>";
        action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_el"]]end'';
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<A-right>";
        action = ''&cedit.'el'.'<c-c><c-r>=execute("redraw")<cr>' '';
        mode = commandModes;
        options.expr = true;
      }

      # Cmd / Ctrl + S
      {
        key = "<C-s>";
        action = "<Cmd>w<CR>";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-s>";
        action = "<Cmd>w<CR>";
        mode = genericModes ++ [ "i" ];
      }

      # Cmd + C
      {
        key = "<D-c>";
        action = "<cmd>normal \"+y<cr>";
        mode = genericModes;
      }

      # Shift + Movement
      {
        key = "<S-up>";
        action.__raw = "function()vim.g.select_move('k');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-down>";
        action.__raw = "function()vim.g.select_move('j');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-left>";
        action.__raw = "function()vim.g.select_move('h');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-right>";
        action.__raw = "function()vim.g.select_move('l');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-A-down>";
        action.__raw = "function()vim.g.select_move('}');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-A-up>";
        action.__raw = "function()vim.g.select_move('{');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-A-left>";
        action.__raw = "function()vim.g.select_move('b');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-A-right>";
        action.__raw = "function()vim.g.select_move('el');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-D-down>";
        action.__raw = "function()vim.g.select_move('G');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-D-up>";
        action.__raw = "function()vim.g.select_move('gg');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-D-left>";
        action.__raw = "function()vim.g.select_move('^');end";
        mode = genericModes ++ ["i"];
      }
      {
        key = "<S-D-right>";
        action.__raw = "function()vim.g.select_move('$l');end";
        mode = genericModes ++ ["i"];
      }


      # Cmd / Ctrl + /
      {
        key = "<C-/>";
        options.desc = "Comment line";
        action = "<cmd>normal gcc<cr>";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-/>";
        options.desc = "Comment line";
        action = "<cmd>normal gcc<cr>";
        mode = genericModes ++ [ "i" ];
      }

      # Cmd + Z / Cmd + Shfit + Z
      {
        key = "<D-z>";
        action = "<cmd>undo<cr>";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-S-z>";
        action = "<cmd>redo<cr>";
        mode = genericModes ++ [ "i" ];
      }

      # Cmd + W
      {
        key = "<D-w>";
        options.desc = "Close current buffer";
        action = "<Cmd>Bdelete<CR>";
        mode = genericModes ++ [ "i" ];
      }

      # Cmd + Shift + W
      {
        key = "<D-W>";
        options.desc = "Quit Neovim";
        action = "<Cmd>qa<CR>";
        mode = genericModes ++ [ "i" ];
      }

      # Cmd + Option + Left / Right
      {
        key = "<D-A-C-left>";
        options.desc = "Previous Tab";
        action = "<Cmd>tabprevious<CR>";
        mode = genericModes ++ [ "i" ];
      }
      {
        key = "<D-A-C-right>";
        options.desc = "Next Tab";
        action = "<Cmd>tabnext<CR>";
        mode = genericModes ++ [ "i" ];
      }
    ]

    (lib.mkIf xcodeEnable [
      {
        key = "<leader>c";
        options.desc = "Clear Console";
        action.__raw = "require('xcodebuild.integrations.dap').clear_console";
        mode = genericModes;
      }
      {
        key = "<D-.>";
        options.desc = "Stop Task";
        action = "<cmd>XcodebuildCancel<cr>";
        mode = genericModes;
      }
      {
        key = "<D-r>";
        options.desc = "Build and Debug";
        action.__raw = "require('xcodebuild.integrations.dap').build_and_debug";
        mode = genericModes;
      }
      {
        key = "<D-b>";
        options.desc = "Build Project";
        action = "<cmd>XcodebuildBuild<cr>";
        mode = genericModes;
      }
      {
        key = "<leader>xl";
        options.desc = "Toggle Logs";
        action = "<cmd>XcodebuildToggleLogs<cr>";
        mode = genericModes;
      }
      {
        key = "<leader>xb";
        options.desc = "Build Project";
        action = "<cmd>XcodebuildBuild<cr>";
        mode = genericModes;
      }
      {
        key = "<leader>xr";
        options.desc = "Build and Run";
        action = "<cmd>XcodebuildBuildRun<cr>";
        mode = genericModes;
      }
      {
        key = "<leader>xd";
        options.desc = "Select Device";
        action = "<cmd>XcodebuildSelectDevice";
        mode = genericModes;
      }
      {
        key = "<leader>xq";
        options.desc = "Quickfix";
        action = "<cmd>Telescope quickfix<cr>";
        mode = genericModes;
      }
      {
        key = "<leader>b";
        options.desc = "Toggle Breakpoint";
        action.__raw = "require('xcodebuild.integrations.dap').toggle_breakpoint";
        mode = genericModes;
      }
      {
        key = "<leader>B";
        options.desc = "Toggle Message Breakpoint";
        action.__raw = "require('xcodebuild.integrations.dap').toggle_message_breakpoint";
        mode = genericModes;
      }
      {
        key = "<leader>xD";
        options.desc = "Debug without Building";
        action.__raw = "require('xcodebuild.integrations.dap').debug_without_build";
        mode = genericModes;
      }
      {
        key = "<leader>X";
        options.desc = "Open Xcodebuild Actions";
        action = "<cmd>XcodebuildPicker<cr>";
        mode = genericModes;
      }
    ])
  ];
}
