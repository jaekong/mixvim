{ pkgs, lib, config, ... }:
let
  fromGitHub = rev: owner: repo: hash: pkgs.vimUtils.buildVimPlugin {
    name = "${lib.strings.sanitizeDerivationName repo}";
    src = pkgs.fetchFromGitHub {
      owner = owner;
      repo = repo;
      rev = rev;
      hash = hash;
    };
  };
  xcodeEnable = config.mixvim.xcode.enable;

  xcode-nvim = lib.mkIf xcodeEnable (fromGitHub "v3.5.1" "wojciech-kulik" "xcodebuild.nvim" "sha256-AUYMOasLldv0WAlNe8qOWpgDNx31v7hxFbhncuTg7Hs=");
in
{
  extraPlugins = lib.mkMerge (with pkgs.vimPlugins; [
    [
      camelcasemotion
      nui-nvim
      smart-splits-nvim
      neorepl-nvim
    ]
    (lib.mkIf xcodeEnable [
      xcode-nvim
    ])
  ]);
}
