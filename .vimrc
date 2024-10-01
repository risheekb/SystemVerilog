"plugins for vim
"Steps to install plugin
" 1. Plug <plugin name>
" 2. $ vim +PlugInstall +qall
call plug#begin()
  Plug 'vhda/verilog_systemverilog.vim' "FOR SYSTEM VERILOG HIGHLIGHTING
  Plug 'ervandew/supertab' "FOR SUPERTAB COMPLETION
  Plug 'preservim/tagbar'
  Plug 'vim-airline/vim-airline'
  Plug 'preservim/nerdtree'
  Plug 'vimtaku/hl_matchit.vim' "FOR COMPLIMENTING MATCHIT
  Plug 'rakr/vim-one'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'morhetz/gruvbox'
  Plug 'sonph/onehalf'
  Plug 'vim-scripts/pyte'
  Plug 'vim-airline/vim-airline-themes'

call plug#end()
"let g:airline_theme='onedark'
"set t_Co=256
set background=light
let g:airline#extensions#tabline#formatter = 'default'
"let g:airline_section_a = 'a'  " Set the first section to show the filename
"let g:airline_section_b = ''
"let g:airline_section_c = ''
"let g:airline_section_x = ''
let g:airline_section_y = ''
"let g:airline_section_z = ''
let g:airline#extensions#tabline#fnamemod = 'relative'  " Use relative path
set termguicolors
colorscheme pyte
syn on
runtime macros/matchit.vim
set nocompatible
set number
set showmode
set backspace=indent,eol,start
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevelstart=10
set hlsearch
set incsearch
set autoindent
set expandtab tabstop=4 softtabstop=2 shiftwidth=2
imap jj <Esc>
set belloff=all
highlight Comment ctermfg=Blue guifg=#0066cc
"############################ KEYMAPPINGS ############################
nnoremap <leader>i :VerilogFollowInstanc<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
nnoremap <leader>u :VerilogGotoInstanceStart<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeFileLines = 1

"NAVIGATION
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
noremap <C-k> <C-w><C-k>
noremap <C-j> <C-w><C-j>

" Toggle relative line numbers and regular line numbers.^M
map <F6> :set invrelativenumber<CR>

"to search for the term under the cursor or a visual selection and then press a key below to replace all instances of it in the current
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
