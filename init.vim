set tabstop=2
set shiftwidth=2
set expandtab
syntax on

set autoindent
set cindent
let &t_Co=256
set termencoding=utf-8
set encoding=utf-8
set termguicolors
set hidden
set number

set termguicolors

autocmd FileType make setlocal noexpandtab

call plug#begin()
" General
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'
Plug 'vim-airline/vim-airline'

" Programming
Plug 'pboettch/vim-cmake-syntax'
Plug 'rhysd/vim-clang-format'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'w0rp/ale'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-clang'
Plug 'derekwyatt/vim-scala'
call plug#end()
let g:deoplete#enable_at_startup = 1

let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>t :terminal<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>a :call CurtineIncSw()<CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Formatting
let g:clang_format#auto_format=1

" license stuff
au bufnewfile *.c so $HOME/.config/nvim/c-header.txt
au bufnewfile *.h so $HOME/.config/nvim/c-header.txt
au bufnewfile *.js so $HOME/.config/nvim/c-header.txt

let g:deoplete#sources#rust#rust_source_path='/Users/gb/rust-src/src'
let g:deoplete#sources#rust#racer_binary='/Users/gb/.cargo/bin/racer'
