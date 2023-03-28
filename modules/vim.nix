{ config, pkgs, lib, ... }: {

  environment.variables = rec {
    EDITOR = "vim";
  };
  
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name="vim";
      vimrcConfig.packages.myplugins= with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        set nocompatible
        set backspace=indent,eol,start
        syntax on
        set undofile
        set hlsearch
        set ruler
        set number
        set showcmd
        set wildmenu
        set ttimeout
        set ttimeoutlen=100
        set incsearch
        set nrformats-=octal

        set swapfile
        set dir=~/tmp//
        set backupdir=~/tmp//
        set undodir=~/tmp//

        filetype plugin indent on

        " save a read-only file
        cmap w!! %!sudo tee > /dev/null %
      
        '';
      }
      )
    ];
  }



