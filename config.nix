{ config, lib, ... }:
let
  xcodeEnable = config.mixvim.xcode.enable;
  rpcEnable = config.mixvim.rpc.enable;
in
{
  config = {
    opts = {
      tabstop = 8;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      autoindent = true;
      virtualedit = "onemore";

      relativenumber = true;
      numberwidth = 4;
      signcolumn = "number";

      ignorecase = true;

      termguicolors = true;

      splitbelow = true;
      splitright = true;

      wildmode = "";

      wrap = false;

      langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz,ㅃQ,ㅉW,ㄸE,ㄲR,ㅆT";

      fillchars = {
        eob = " ";
      };
    };

    globals = {
      mapleader = " ";
    };

    extraConfigVim = ''
      language en_US.UTF-8
      set noshowmode
      set nowildmenu
    '';
    extraConfigLua = lib.strings.concatStrings [
      (if xcodeEnable then (builtins.readFile ./luaConfig/xcodebuild.lua) else "")
      (if rpcEnable then (builtins.readFile ./luaConfig/rpc.lua) else "")
      (builtins.readFile ./neovim.lua)
    ];

    performance = {
      byteCompileLua = {
        enable = true;
        plugins = true;
      };
    };

    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "main";
        styles.italic = false;
      };
    };
  };
}
