{ config, lib, ... }:
let
  genericModes = config.mixvim.genericModes;
  commandModes = config.mixvim.commandModes;
  xcodeEnable = config.mixvim.xcode.enable;
  system = config.mixvim.system;
in
{
  keymaps = lib.mkMerge [
  [
    {
      key = "w";
      action = "<Plug>CamelCaseMotion_w";
      mode = genericModes;
    }
    {
      key = "b";
      action = "<Plug>CamelCaseMotion_b";
      mode = genericModes;
    }
    {
      key = "e";
      action = "<Plug>CamelCaseMotion_e";
      mode = genericModes;
    }
    {
      key = "ge";
      action = "<Plug>CamelCaseMotion_ge";
      mode = genericModes;
    }
    {
      key = "s";
      action = "<nop>";
      mode = genericModes;
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
        if vim.api.nvim_get_mode()["mode"] == "v" then
          vim.api.nvim_feedkeys("+", "v", false);
          vim.api.nvim_feedkeys("$", "v", false);
        else
          local currentLine = vim.fn.line(".")
          local currentLineEndColumn = vim.fn.line("$") - 1
          vim.fn.setpos("\'<", {0, currentLine, 0, 0})
          vim.fn.setpos("\'>", {0, currentLine, currentLineEndColumn, 0})
          vim.api.nvim_feedkeys("gv", "n", false);
        end
      end
      '';
      mode = genericModes;
    }
    # {
    #   key = "<Tab>";
    #   action.__raw = ''
    #   function()
    #     local col = vim.fn.col('.') - 1
    #     local line = vim.fn.getline('.')
    #
    #     if col == 0 or string.match(line, '^%s+$') then
    #       vim.cmd("norm! ==")
    #     else
    #       vim.api.nvim_feedkeys("\t", 'i', false)
    #     end
    #   end
    #   '';
    #   mode = "i";
    # }

    {
      key = "<leader>?";
      action.__raw = "function()require('which-key').show({ global = false })end";
      mode = genericModes;
    }

    {
      key = "<leader>D";
      action.__raw = "require('dapui').toggle";
      mode = genericModes;
    }

    {
      key = "\\";
      action = "<cmd>Neotree toggle<cr>";
      mode = genericModes;
    }

    {
      key = "<A-h>";
      action.__raw = "require('smart-splits').resize_left";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-j>";
      action.__raw = "require('smart-splits').resize_down";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-k>";
      action.__raw = "require('smart-splits').resize_up";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-l>";
      action.__raw = "require('smart-splits').resize_right";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    {
      key = "<C-h>";
      action.__raw = "require('smart-splits').move_cursor_left";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-j>";
      action.__raw = "require('smart-splits').move_cursor_down";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-k>";
      action.__raw = "require('smart-splits').move_cursor_up";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-l>";
      action.__raw = "require('smart-splits').move_cursor_right";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-d>";
      action = "<Cmd>rightb:vsplit<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-S-d>";
      action = "<Cmd>rightb:split<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    # macOS Style Keybind
    # Option + up / down
    {
      key = "<A-up>";
      action = "{";
      mode = genericModes;
      options.remap = false;
    }
    {
      key = "<A-up>";
      action = "<esc>{i";
      mode = "i";
      options.remap = false;
    }
    {
      key = "<A-down>";
      action = "}";
      mode = genericModes;
      options.remap = false;
    }
    {
      key = "<A-down>";
      action = "<esc>}i";
      mode = "i";
      options.remap = false;
    }

    # Cmd + up / down
    {
      key = "<D-up>";
      action = "gg";
      mode = genericModes;
      options.remap = false;
    }
    {
      key = "<D-up>";
      action = "<esc>ggi";
      mode = "i";
      options.remap = false;
    }
    {
      key = "<D-down>";
      action = "G";
      mode = genericModes;
      options.remap = false;
    }
    {
      key = "<D-down>";
      action = "<esc>Gi";
      mode = "i";
      options.remap = false;
    }

    # Cmd + backspace
    {
      key = "<D-backspace>";
      action.__raw = "function()vim.g.if_is_at_start('norm! d0', 'norm! d^')end";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-backspace>";
      action = ''&cedit.'d0'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Option + backspace
    {
      key = "<A-backspace>";
      action.__raw = ''function()vim.cmd [[execute "norm! d\<Plug>CamelCaseMotion_b"]]end'';
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-backspace>";
      action = ''&cedit.'db'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Cmd + left / right
    {
      key = "<D-left>";
      action.__raw = "function()vim.g.if_is_at_start('norm! 0', 'norm! ^')end";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-left>";
      action = ''&cedit.'0'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }
    {
      key = "<D-right>";
      action.__raw = "function()vim.cmd('norm! $l')end";
      mode = genericModes ++ commandModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-right>";
      action = ''&cedit.'$'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Option + left / right
    {
      key = "<A-left>";
      action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_b"]]end'';
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-left>";
      action = ''&cedit.'b'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }
    {
      key = "<A-right>";
      action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_w"]]end'';
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-right>";
      action = ''&cedit.'w'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Cmd / Ctrl + S
    {
      key = "<C-s>";
      action = "<Cmd>w<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-s>";
      action = "<Cmd>w<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Ctrl + C
    {
      key = "<C-/>";
      action = "<cmd>normal gcc<cr>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-/>";
      action = "<cmd>normal gcc<cr>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Cmd + Z / Cmd + Shfit + Z
    {
      key = "<D-z>";
      action = "<cmd>undo<cr>";
      mode = genericModes;
    }
    {
      key = "<D-S-z>";
      action = "<cmd>redo<cr>";
      mode = genericModes;
    }

    # Cmd + W
    {
      key = "<D-w>";
      action = "<Cmd>Bdelete<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Cmd + Shift + W
    {
      key = "<D-W>";
      action = "<Cmd>qa<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Cmd + Option + Left / Right
    {
      key = "<D-A-C-left>";
      action = "<Cmd>tabprevious<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<D-A-C-right>";
      action = "<Cmd>tabnext<CR>";
      mode = genericModes ++ [ "i" ];
      options.remap = false;
    }

    {
      key = "asdf";
      action = "<Cmd>echo '${system}'<cr>";
      mode = genericModes;
      options.remap = false;
    }
  ]
  (lib.mkIf xcodeEnable [
    {
      key = "<leader>c";
      action.__raw = "require('xcodebuild.integrations.dap').clear_console";
      mode = genericModes;
    }
  ])
  ];
}
