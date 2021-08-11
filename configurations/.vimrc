
"    __   _(_)_ __ ___  _ __ ___ 
"    \ \ / / | '_ ` _ \| '__/ __|
"     \ V /| | | | | | | | | (__ 
"      \_/ |_|_| |_| |_|_|  \___|
"
" source: https://github.com/sdatth/dotfiles
"

" Vim config file 
" config file location "~/.vimrc"
" dependencies
" vim plug needs to be installed , follow this guide -> "https://github.com/junegunn/vim-plug" 
" vim-gtk package needs to be installed to enable copy-paste functionality to sys clipboard

" to set the editor to not to act like the old version of vi
set nocompatible
filetype off

" this is the basic config file
syntax enable
set belloff=all
set smartindent 
set expandtab
set number relativenumber
set nowrap
set smartcase
set incsearch
set mouse=a
set showcmd
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noswapfile
set scrolloff=5
set encoding=UTF-8

" leader key
let mapleader = "," 

"{ this is the key binding section
" to copy contents to sys clipboard
noremap <leader>c "+y

" to paste sys clipboard content 
noremap <leader>v "+p

" to quit without saving
noremap <leader>x :q!<CR>

" to save the file
noremap <leader>o :w<CR>

" close current buffer
noremap <leader>f :bd<CR>

" to source the nvim config file
noremap <leader>s :source%<CR> 

" to invoke fzf finder {use Ctrl+t to open the file in a new tab}
noremap <leader>; :Files ~/Stuff/<CR>
noremap <leader>d :Files ~/dotfiles/<CR>

" to invoke nerdtree {use shift+t to open the file in a new tab}
noremap <leader>n :NERDTreeToggle<CR>

" to comment a selected content with double quotations '"''
vmap <leader>l gc

" to change focus to different window
noremap <leader>w <C-w>

" to change focus to different tab
noremap <leader>t gt

" to preview shortcuts of leader key
noremap <leader>h :<c-u>WhichKey  ','<CR>

" to execute python files
noremap <leader>e <Esc>:w<CR>:!clear;python3 %<CR>

" to execute bash scripts 
noremap <leader>b <Esc>:w<CR>:!clear;bash %<CR>

" git gutter
noremap <leader>g <Esc>:GitGutterToggle <CR>

"} this is end of the key binding section



" this is the plugin section
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'jacoborus/tender.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'liuchengxu/vim-which-key'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
call plug#end()

" disable gitgutter at startup
" let g:gitgutter_enabled = 0

" colour scheme of the editor
colorscheme tender

