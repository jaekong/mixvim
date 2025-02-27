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
    doCheck = false;
  };

  xcode-nvim = (fromGitHub "v5.2.0" "wojciech-kulik" "xcodebuild.nvim" "sha256-vk47KvlXygX1D46k/odlBx0Ym7isKQQ+HP9QU+Q6AL0=");
  mellow-nvim = (fromGitHub "434a02d5f7637a24824569426176f37473205053" "mellow-theme" "mellow.nvim" "sha256-Lr4+KxQRsTJrqwGtRMcxBwDZq84v6Pl4NUcfu+5XhRs=");
in
{
  extraPlugins = lib.mkMerge (with pkgs.vimPlugins; [
    [
      camelcasemotion
      nui-nvim
      # smart-splits-nvim
      neorepl-nvim
      hover-nvim
      mellow-nvim
    ]
    (lib.mkIf xcodeEnable [
      xcode-nvim
    ])
  ]);
}
