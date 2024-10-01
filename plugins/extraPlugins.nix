{ pkgs, lib, config, ... }:
let
  xcodeEnable = config.mixvim.xcode.enable;

  fromGitHub = rev: owner: repo: hash: pkgs.vimUtils.buildVimPlugin {
    name = "${lib.strings.sanitizeDerivationName repo}";
    src = pkgs.fetchFromGitHub {
      owner = owner;
      repo = repo;
      rev = rev;
      hash = hash;
    };
  };

  xcode-nvim = lib.mkIf xcodeEnable (fromGitHub "v3.6.0" "wojciech-kulik" "xcodebuild.nvim" "sha256-LPf9MSdl7+4WVMH3t6slokO0xZ2Q8OBoJIlvvjj2QOU=");
in
{
  extraPlugins = lib.mkMerge (with pkgs.vimPlugins; [
    [
      camelcasemotion
      nui-nvim
      smart-splits-nvim
      neorepl-nvim
      hover-nvim
    ]
    (lib.mkIf xcodeEnable [
      xcode-nvim
    ])
  ]);
}
