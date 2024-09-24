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
      language en_US
      set noshowmode
    '';
    extraConfigLua = builtins.readFile ./neovim.lua;

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
