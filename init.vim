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
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'fatih/vim-go'
Plug 'preservim/nerdtree'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'udalov/kotlin-vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch' " Make
Plug 'liuchengxu/vista.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'morhetz/gruvbox'
Plug 'ocaml/vim-ocaml'
Plug 'elixir-editors/vim-elixir'
Plug 'derekwyatt/vim-scala'
Plug 'guns/vim-clojure-static'
Plug 'HerringtonDarkholme/yats.vim'
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

"nmap <silent> so :TagbarOpenAutoClose<CR>

" coc
nmap <Leader>rn <Plug>(coc-rename)
" nmap <silent> so :CocList outline<CR>
nmap <silent> so :Vista<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gh :CocFix<CR>
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
      \ 'python' : 'python3 $fileName',
      \ 'kotlin' : 'kotlinc -J-ea -script $fileName',
      \ 'scala' : 'scalac $filename && scala $fileNameWithoutExt',
      \}
let g:code_runner_output_window_size=10

let g:tex_flavor = "latex"

"imap <C-l> <Plug>(coc-snippets-expand)

function! LightlineFilename()
  return expand('%')
endfunction

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'method', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding' ] ]
      \ },
      \ }


let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 1' " view per byte 

" use coc
let g:go_code_completion_enabled = 0

autocmd FileType tex setlocal spell
let g:dispatch_no_maps = 1

au FileType kotlin setlocal makeprg=kotlinc\ -jvm-target\ 1.8\ -Werror\ %\ -include-runtime\ -d\ %.jar
au FileType java setlocal makeprg=javac\ -Xlint\:all\ %
au FileType pandoc setlocal makeprg=pandoc\ %\ -o\ %\.pdf\ --number-sections\ --toc\ --pdf-engine=xelatex\ -V\ 'mainfont:Times'\ -V\ 'monofont:Monaco'
au BufRead,BufNewFile *.ditaa setlocal makeprg=ditaa\ %
au BufRead,BufNewFile *.hs setlocal makeprg=stack\ build

if executable('ag')
  let g:ackprg = "ag -w --ignore='*.rst' --ignore='*Test*' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --ignore='target' --ignore='build' --vimgrep"
endif

let g:fzf_preview_window = ''

let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 0

colorscheme gruvbox
