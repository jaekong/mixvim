{ config, lib, ... }:
let
  xcodeEnable = config.mixvim.xcode.enable;
  rpcEnable = config.mixvim.rpc.enable;
in
{
  config = {
    opts = {
      autoindent = true;
      expandtab = true;
      smartindent = true;

      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 8;
      
      eadirection = "both";
      splitbelow = true;
      splitright = true;

      numberwidth = 4;
      relativenumber = true;
      signcolumn = "number";

      fillchars.eob = " ";
      ignorecase = true;
      langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz,ㅃQ,ㅉW,ㄸE,ㄲR,ㅆT";
      termguicolors = true;
      virtualedit = "onemore";
      wildmode = "";
      wrap = false;
    };

    globals = {
      mapleader = " ";
    };

    extraConfigVim = ''
      language en_US.UTF-8

      set equalalways
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
