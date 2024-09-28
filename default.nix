{ lib, mixvim, system, ... }:
{
  options.mixvim.genericModes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "n" "v" "s" "o" ];
  };
  options.mixvim.commandModes = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "c" ];
  };
  options.mixvim.xcode.enable = lib.mkOption {
    type = lib.types.bool;
    default = mixvim.xcode.enable;
  };
  options.mixvim.rpc.enable = lib.mkOption {
    type = lib.types.bool;
    default = mixvim.rpc.enable;
  };
  options.mixvim.system = lib.mkOption {
    type = lib.types.str;
    default = system;
  };
  imports = [
    ./plugins
    ./keymaps.nix
    ./config.nix
  ];
}
