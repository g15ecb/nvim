" =============================================================================
" General 
" =============================================================================
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
set directory^=$HOME/swap
autocmd FileType make setlocal noexpandtab

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'haya14busa/incsearch.vim'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'dagwieers/asciidoc-vim'
Plug 'antoyo/vim-licenses'
Plug 'pboettch/vim-cmake-syntax'
Plug 'rhysd/vim-clang-format'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'w0rp/ale'
Plug 'neapel/vim-java-bytecode'
Plug 'fatih/vim-go'
call plug#end()

" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>t :MerlinTypeOf<CR>
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

" =============================================================================
" Completion
" =============================================================================
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview
let g:ycm_semantic_triggers =  { 'java,jsp' : ['.'], }

" =============================================================================
" Formatting (C++,C,Java)
" =============================================================================
let g:clang_format#auto_format=1

" =============================================================================
" License 
" =============================================================================
let g:licenses_copyright_holders_name = 'Barnett, Granville <granvillebarnett@gmail.com>'
let g:licenses_authors_name = 'Barnett, Granville <granvillebarnett@gmail.com>'
au BufNewFile *.java Mit
au BufNewFile *.h Mit
au BufNewFile *.c Mit
au BufNewFile *.go Mit

" =============================================================================
" Java 
" =============================================================================
au BufNewFile,BufRead *.javap setf java-bytecode

" =============================================================================
" C/C++ 
" =============================================================================
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" =============================================================================
" Go
" =============================================================================
let g:go_template_autocreate = 0
