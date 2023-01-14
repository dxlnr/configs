set shell=/bin/bash
let mapleader =","

" ========================================
" Plugins
" ========================================

" Install vim-plug if it is not installed yet.
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin()

" GUI
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

colorscheme nord

" ========================================
" GUI Settings
" ========================================
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set mouse=a
