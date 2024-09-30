{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;
      cmdline = {
        "/" = {
          sources = [
            { name = "buffer"; }
            { name = "nvim_lsp_document_symbol"; }
          ];
          mapping = {
            "<up>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<down>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select=true })";
          };
        };

        ":" = {
          sources = [
            { name = "cmdline"; }
            { name = "nvim_lsp_document_symbol"; }
          ];
        };
      };
      filetype = {};
      settings = {
        sources = [
          {
            name = "nvim_lsp";
            entry_filter.__raw = ''
              function(entry, ctx)
                local kind = entry:get_kind()

                if kind == 1 then
                  return false
                else
                  return true
                end
              end
            '';
          }
          { name = "nvim_lua"; }
          { name = "luasnip"; }
        ];
        mapping = {
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<C-up>" = "cmp.mapping.scroll_docs(-4)";
          "<C-down>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select=true })";
          "<down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        };
        filetype = {
          TelescopePrompt = {
            autocomplete = false;
          };
        };
        window = {
          completion = {
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
              scrollbar = false;
              sidePadding = 0;
              border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
          };
          settings.documentation = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
          };
        };
        preselect = "cmp.PreselectMode.None";
        snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
        '';
        enabled.__raw = ''
          function()
            local context = require 'cmp.config.context'

            local isEmptyLine = function()
              local col = vim.fn.col('.') - 1
              local line = vim.fn.getline('.')
              local char_under_cursor = string.sub(line, 0, col)

              if col == 0 or string.match(char_under_cursor, '^%s+$') then
                return true
              else
                return false
              end
            end

            if vim.api.nvim_get_mode().mode == 'c' then
              return true
            else
              return not isEmptyLine()
                and not context.in_treesitter_capture("comment")
                and not context.in_treesitter_capture("string")
                and not context.in_syntax_group("Comment")
            end
          end
        '';
      };
    };
    # cmp-nvim-lsp.enable = true;
    # cmp-nvim-lua.enable = true;
    # cmp-buffer.enable = true;
    # cmp-nvim-lsp-document-symbol.enable = true;
    # cmp_luasnip.enable = true;
  };
}
