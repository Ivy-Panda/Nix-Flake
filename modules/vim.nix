{ config, pkgs, lib, self, ... }: {

  environment.variables = rec {
    EDITOR = "vim";
  };

  system.activationScripts = { text = "mkdir -p /home/ivy/tmp"; };

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
        set hlsearch
        set ruler
        set number
        set relativenumber
        set showcmd
        set wildmenu
        set ttimeout
        set ttimeoutlen=50
        set incsearch
        set ignorecase
        set nrformats-=octal
        set hidden

        set undofile
        set swapfile
        set directory=~/tmp/dir//
        set backupdir=~/tmp/backupdir//
        set undodir=~/tmp/undodir//

        for i in [ &undodir, &directory, &backupdir ]
          call mkdir(i, "p")
        endfor

        filetype plugin indent on

        " save a read-only file
        cmap w!! %!sudo tee > /dev/null %

        " remap ESC to ;
        noremap  <C-;> <esc>
        inoremap <C-;> <esc>
        cnoremap <C-;> <C-C>

      '';
    }
    )
  ];
}

