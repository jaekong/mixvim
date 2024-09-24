{ pkgs, lib, generalModes, ... }:
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

  xcode-nvim = (fromGitHub "v3.5.1" "wojciech-kulik" "xcodebuild.nvim" "sha256-AUYMOasLldv0WAlNe8qOWpgDNx31v7hxFbhncuTg7Hs=");
in
  {
    extraPlugins = with pkgs.vimPlugins; [
      xcode-nvim
      camelcasemotion
      nui-nvim
      smart-splits-nvim
      neorepl-nvim
    ];
  }
