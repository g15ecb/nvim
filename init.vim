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

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'mileszs/ack.vim'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'airblade/vim-rooter'
Plug 'xianzhon/vim-code-runner'
Plug 'inside/vim-search-pulse'
Plug 'solarnz/thrift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
nnoremap <Leader>m :make<CR>
nnoremap <Leader>l :ALEDetail<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

" coc
nmap <Leader>rn <Plug>(coc-rename)
nmap <silent> so :CocList outline<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
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

" ALE
let g:ale_fixers = {
\   'java': ['google_java_format'],
\   'c': ['clang-format'],
\   'h': ['clang-format'],
\   'c++': ['clang-format'],
\   'cpp': ['clang-format'],
\   'python': ['isort', 'black'],
\   'markdown': ['prettier'],
\   'pandoc': ['prettier'],
\   'json': ['prettier'],
\   'javascript': ['prettier'],
\   'js': ['prettier'],
\   'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
" to stop pep8 based linters from complaining as black uses 88 as line length
let g:ale_python_black_options = '-l 79'
let g:ale_javascript_prettier_options = '--prose-wrap always'

" Ag
if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

" Pandoc
let g:pandoc#modules#disabled = ["folding"]

" Airline 
let g:airline_section_b='' " vcs info
let g:airline_section_x='' " filetype
let g:airline_section_z='%{line("$")}:%{col(".")}'
let g:airline_section_c='%t'
let g:airline_section_y='' " file encoding
" the below denote warnings etc that linters flag. 
let g:airline_section_error='' 
let g:airline_section_warning=''

" marker components to point out the root of a project
let g:rooter_patterns = ['makefile', 'Rakefile', 'gradlew', '.git/', 'pom.xml']

" Code runner
let g:CodeRunnerCommandMap = {
      \ 'java' : 'javac -Xlint:all $fileName && java -ea $fileNameWithoutExt',
      \ 'python' : 'python3 $fileName',
      \ 'c' : 'clang -std=c11 $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt',
      \ 'cpp' : 'clang++ -std=c++14 $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt',
      \}
let g:code_runner_output_window_size=10

" shortform abbreviations for the current mode
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'c'  : 'C',
      \ 'i'  : 'I',
      \ 'ic' : 'I',
      \ 'ix' : 'I',
      \ 'n'  : 'N',
      \ 'ni' : 'N',
      \ 'no' : 'N',
      \ 'R'  : 'R',
      \ 'Rv' : 'R',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ ''   : 'S',
      \ 't'  : 'T',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ }

let g:tex_flavor = "latex"

imap <C-l> <Plug>(coc-snippets-expand)

au BufRead,BufNewFile *.sbt set filetype=scala
