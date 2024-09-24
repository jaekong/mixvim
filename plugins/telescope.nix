{ config, ... }:
{
  plugins.telescope = {
    enable = true;
    extensions = {
      media-files.enable = true;
      ui-select = {
        enable = true;
      };
      undo = {
        enable = true;
      };
    };
    keymaps = {
      "<leader>ff" = {
        action = "fd";
        mode = config.nvim.genericModes;
      };
      "<leader>fg" = {
        action = "live_grep";
        mode = config.nvim.genericModes;
      };
      "<leader><leader>" = {
        action = "buffers";
        mode = config.nvim.genericModes;
      };
      "<leader>f:" = {
        action = "commands";
        mode = config.nvim.genericModes;
      };
      "<leader>fq" = {
        action = "quickfix";
        mode = config.nvim.genericModes;
      };
      "<leader>fl" = {
        action = "lsp_definitions";
        mode = config.nvim.genericModes;
      };
      "<leader>fd" = {
        action = "diagnostics";
        mode = config.nvim.genericModes;
      };
      "<C-f>" = { 
        action = "find_files";
        mode = config.nvim.genericModes;
      };
    };
  };
}
