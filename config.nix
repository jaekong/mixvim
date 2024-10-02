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
      fillchars.vert = "▕";
      ignorecase = true;
      langmap = "ㅁa,ㅠb,ㅊc,ㅇd,ㄷe,ㄹf,ㅎg,ㅗh,ㅑi,ㅓj,ㅏk,ㅣl,ㅡm,ㅜn,ㅐo,ㅔp,ㅂq,ㄱr,ㄴs,ㅅt,ㅕu,ㅍv,ㅈw,ㅌx,ㅛy,ㅋz,ㅃQ,ㅉW,ㄸE,ㄲR,ㅆT";
      termguicolors = true;
      virtualedit = "onemore";
      wildmode = "";
      wrap = false;
    };

    diagnostics = {
      signs.__raw = ''
      function()
        return {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 "
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn"
          }
        }
      end
      '';
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
        highlight_groups = {
          LineNrAbove.fg.__raw = "require('rose-pine.palette').muted";
          LineNrBelow.fg.__raw = "require('rose-pine.palette').muted";
          LineNr = {
            fg.__raw = "require('rose-pine.palette').base";
            bg.__raw = "require('rose-pine.palette').subtle";
          };
          DiagnosticSignError = {
            bg.__raw = "require('rose-pine.palette').love";
            fg.__raw = "require('rose-pine.palette').base";
          };
          DiagnosticSignWarn = {
            bg.__raw = "require('rose-pine.palette').gold";
            fg.__raw = "require('rose-pine.palette').base";
          };
        };
      };
    };
  };
}
