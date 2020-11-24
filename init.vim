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
filetype plugin indent on
set cursorline
highlight clear CursorLine
set background=dark
highlight clear SignColumn " make the gutter same colour as lines

set colorcolumn=100

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'xianzhon/vim-code-runner'
Plug 'inside/vim-search-pulse'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'solarnz/thrift.vim'
Plug 'uarun/vim-protobuf'
Plug 'fidian/hexmode'
Plug 'vhdirk/vim-cmake'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'fatih/vim-go'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-dispatch' " Make
Plug 'liuchengxu/vista.vim'
Plug 'morhetz/gruvbox'
Plug 'ocaml/vim-ocaml'
Plug 'udalov/javap-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'derekwyatt/vim-scala'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'liuchengxu/graphviz.vim'
Plug 'udalov/kotlin-vim'
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
call plug#end()


" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>c :TOC<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :Make<CR> 
nnoremap <Leader>t :NERDTree %<CR>
nnoremap <Leader>l :GoRun<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

nmap <silent> + :cnext<CR>
nmap <silent> - :cprevious<CR>

" coc
nmap <Leader>rn <Plug>(coc-rename)
nmap <silent> so :CocList outline<CR>
nmap <silent> sl :Vista<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [[ :CocCommand java.projectConfiguration.update<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gh :CocFix<CR>
nmap <silent> gl :CocCommand metals.build-import<CR>
nnoremap <silent> H :call <SID>show_documentation()<CR>
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Completion 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"set completeopt-=preview
set completeopt=noinsert,menuone,noselect

" Ag
if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='target*' --ignore='project*' --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

" Pandoc
let g:pandoc#modules#disabled = ["folding"]

" Code runner
let g:CodeRunnerCommandMap = {
      \ 'java' : 'java -ea $fileName',
      \ 'python' : 'python $fileName',
      \ 'scala' : 'scala $fileName',
      \ 'ocaml' : 'ocaml $fileName',
      \}
let g:code_runner_output_window_size=10

let g:tex_flavor = "latex"

function! LightlineFilename()
  return expand('%')
endfunction

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding' ] ]
      \ }
      \ }


let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 1' " view per byte 

" use coc
let g:go_code_completion_enabled = 0

autocmd FileType tex setlocal spell
let g:dispatch_no_maps = 1

if executable('ag')
  let g:ackprg = "ag -w --ignore='*.rst' --ignore='*Test*' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --ignore='target' --ignore='build' --vimgrep"
endif

let g:fzf_preview_window = ''

let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0

autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

au FileType ocaml setlocal makeprg=dune\ build
au FileType kotlin setlocal makeprg=./gradlew\ build
au FileType scala setlocal makeprg=sbt\ compile
au FileType cpp setlocal makeprg=clang++\ -std=c++17\ -g\ -Wall\ %\ -o\ %.exe
au FileType java setlocal makeprg=gradle\ compileJava
au FileType pandoc setlocal makeprg=pandoc\ %\ -o\ %\.pdf\ --number-sections\ --toc\ --pdf-engine=xelatex\ -V\ 'mainfont:Arial'\ -V\ 'monofont:Monaco'

let g:coc_filetype_map = {'pandoc': 'markdown'}

colorscheme gruvbox
