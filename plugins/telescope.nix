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
        mode = config.mixvim.genericModes;
      };
      "<leader>fg" = {
        action = "live_grep";
        mode = config.mixvim.genericModes;
      };
      "<leader><leader>" = {
        action = "buffers";
        mode = config.mixvim.genericModes;
      };
      "<leader>f:" = {
        action = "commands";
        mode = config.mixvim.genericModes;
      };
      "<leader>fq" = {
        action = "quickfix";
        mode = config.mixvim.genericModes;
      };
      "<leader>fl" = {
        action = "lsp_definitions";
        mode = config.mixvim.genericModes;
      };
      "<leader>fd" = {
        action = "diagnostics";
        mode = config.mixvim.genericModes;
      };
      "<C-f>" = { 
        action = "find_files";
        mode = config.mixvim.genericModes;
      };
      "<D-f>" = {
        action = "find_files";
        mode = config.mixvim.genericModes;
      };
    };
  };
}
