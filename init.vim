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
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/vim-clang-format'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'
Plug 'godlygeek/tabular'
Plug 'cespare/vim-toml'
Plug 'wannesm/wmgraphviz.vim'
Plug 'rust-lang/rust.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'roxma/nvim-completion-manager'
call plug#end()

let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :BufExplorer<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>a :call CurtineIncSw()<CR>
nnoremap <Leader>t :TagbarOpenAutoClose<CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:ackprg = 'ag --vimgrep'

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
