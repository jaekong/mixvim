{ config, ... }:
{
  keymaps = [
    {
      key = "w";
      action = "<Plug>CamelCaseMotion_w";
      mode = config.nvim.genericModes;
    }
    {
      key = "b";
      action = "<Plug>CamelCaseMotion_b";
      mode = config.nvim.genericModes;
    }
    {
      key = "e";
      action = "<Plug>CamelCaseMotion_e";
      mode = config.nvim.genericModes;
    }
    {
      key = "ge";
      action = "<Plug>CamelCaseMotion_ge";
      mode = config.nvim.genericModes;
    }
    {
      key = "s";
      action = "<nop>";
      mode = config.nvim.genericModes;
    }
    {
      key = "U";
      action = "<cmd>redo<cr>";
      mode = config.nvim.genericModes;
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
      mode = config.nvim.genericModes;
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
      mode = config.nvim.genericModes;
    }

    {
      key = "<leader>D";
      action.__raw = "require('dapui').toggle";
      mode = config.nvim.genericModes;
    }

    {
      key = "\\";
      action = "<cmd>Neotree toggle<cr>";
      mode = config.nvim.genericModes;
    }

    {
      key = "<leader>c";
      action.__raw = "require('xcodebuild.integrations.dap').clear_console";
      mode = config.nvim.genericModes;
    }

    {
      key = "<A-h>";
      action.__raw = "require('smart-splits').resize_left";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-j>";
      action.__raw = "require('smart-splits').resize_down";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-k>";
      action.__raw = "require('smart-splits').resize_up";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-l>";
      action.__raw = "require('smart-splits').resize_right";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }

    {
      key = "<C-h>";
      action.__raw = "require('smart-splits').move_cursor_left";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-j>";
      action.__raw = "require('smart-splits').move_cursor_down";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-k>";
      action.__raw = "require('smart-splits').move_cursor_up";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-l>";
      action.__raw = "require('smart-splits').move_cursor_right";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<M-d>";
      action = "<Cmd>rightb:vsplit<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<M-S-d>";
      action = "<Cmd>rightb:split<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }

    # macOS Style Keybind
    # Option + up / down
    {
      key = "<A-up>";
      action = "{";
      mode = config.nvim.genericModes;
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
      mode = config.nvim.genericModes;
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
      key = "<C-home>";
      action = "gg";
      mode = config.nvim.genericModes;
      options.remap = false;
    }
    {
      key = "<C-home>";
      action = "<esc>ggi";
      mode = "i";
      options.remap = false;
    }
    {
      key = "<C-end>";
      action = "G";
      mode = config.nvim.genericModes;
      options.remap = false;
    }
    {
      key = "<C-end>";
      action = "<esc>Gi";
      mode = "i";
      options.remap = false;
    }

    # Cmd + backspace
    {
      key = "<A-S-backspace>";
      action.__raw = "function()vim.g.if_is_at_start('norm! d0', 'norm! d^')end";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-S-backspace>";
      action = ''&cedit.'d0'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Option + backspace
    {
      key = "<A-backspace>";
      action.__raw = ''function()vim.cmd [[execute "norm! d\<Plug>CamelCaseMotion_b"]]end'';
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-backspace>";
      action = ''&cedit.'db'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Cmd + left / right
    {
      key = "<C-left>";
      action.__raw = "function()vim.g.if_is_at_start('norm! 0', 'norm! ^')end";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-left>";
      action = ''&cedit.'0'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }
    {
      key = "<C-right>";
      action.__raw = "function()vim.cmd('norm! $l')end";
      mode = config.nvim.genericModes ++ config.nvim.commandModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<C-right>";
      action = ''&cedit.'$'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Option + left / right
    {
      key = "<A-left>";
      action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_b"]]end'';
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-left>";
      action = ''&cedit.'b'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }
    {
      key = "<A-right>";
      action.__raw = ''function()vim.cmd [[execute "norm! \<Plug>CamelCaseMotion_w"]]end'';
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<A-right>";
      action = ''&cedit.'w'.'<c-c><c-r>=execute("redraw")<cr>' '';
      mode = config.nvim.commandModes;
      options.remap = false;
      options.expr = true;
    }

    # Cmd / Ctrl + S
    {
      key = "<C-s>";
      action = "<Cmd>w<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Ctrl + C
    {
      key = "<C-/>";
      action = "gcc";
      mode = config.nvim.genericModes;
      options.remap = false;
    }
    {
      key = "<C-/>";
      action = "<esc>gcci";
      mode = "i";
      options.remap = false;
    }

    # Cmd + W
    {
      key = "<M-w>";
      action = "<Cmd>q<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Cmd + Shift + W
    {
      key = "<M-q>";
      action = "<Cmd>qa<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }

    # Cmd + Option + Left / Right
    {
      key = "<M-,>";
      action = "<Cmd>tabprevious<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
    {
      key = "<M-.>";
      action = "<Cmd>tabnext<CR>";
      mode = config.nvim.genericModes ++ [ "i" ];
      options.remap = false;
    }
  ];
}
