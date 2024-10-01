{ config, ... }:
let
  genericModes = config.mixvim.genericModes;
in
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
    settings = {
      defaults = {
        wrap_results = true;
      };
    };
    keymaps = {
      "<leader>ff" = {
        action = "fd";
        mode = genericModes;
      };
      "<leader>fg" = {
        action = "live_grep";
        mode = genericModes;
      };
      "<leader>fb" = {
        action = "buffers";
        mode = genericModes;
      };
      "<leader>f:" = {
        action = "commands";
        mode = genericModes;
      };
      "<leader>fq" = {
        action = "quickfix";
        mode = genericModes;
      };
      "<leader>fl" = {
        action = "lsp_definitions";
        mode = genericModes;
      };
      "<leader>z" = {
        action = "undo";
        mode = genericModes;
      };
      "<leader>fd" = {
        action = "diagnostics";
        mode = genericModes;
      };
      "<leader><leader>" = { 
        action = "find_files";
        mode = genericModes;
      };
      "<leader>gc" = {
        action = "git_commits";
        mode = genericModes;
      };
      "<leader>gs" = {
        action = "git_status";
        mode = genericModes;
      };
      "<D-f>" = {
        action = "find_files";
        mode = genericModes ++ [ "i" ];
      };
      "?" = {
        action = "live_grep";
        mode = genericModes;
      };
    };
  };
}
