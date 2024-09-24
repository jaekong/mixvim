{ lib, ... }:
{
  options.nvim.genericModes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "n" "v" "s" "o" ];
  };
  options.nvim.commandModes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "c" ];
  };
  imports = [
    ./plugins
    ./keymaps.nix
    ./config.nix
  ];
}
