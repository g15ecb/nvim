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
Plug 'majutsushi/tagbar'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'airblade/vim-rooter'
Plug 'xianzhon/vim-code-runner'
Plug 'inside/vim-search-pulse'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'solarnz/thrift.vim'
Plug 'aklt/plantuml-syntax'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-dadbod'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'rust-lang/rust.vim'
Plug 'JesseKPhillips/d.vim'
call plug#end()

" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>t :TagbarOpenAutoClose<CR>
nnoremap <Leader>c :TOC<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>yg :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>yd :YcmCompleter GetDoc<CR>
nnoremap <Leader>yr :YcmCompleter RefactorRename<space>
nnoremap <Leader>yu :YcmCompleter GoToReferences<CR>
nnoremap <Leader>yt :YcmCompleter GetType<CR>
nnoremap <Leader>l :ALEDetail<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 
nnoremap <Leader>r :%DB mysql://hive@granvil01-vm0.bdauto.wandisco.com/hive<CR>

nnoremap <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>lh :call LanguageClient#textDocument_hover()<CR>

" Completion (YCM)
let g:deoplete#enable_at_startup = 1
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

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
"let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tagbar#flags = 's'
"let g:airline#extensions#tagbar#flags = 'p'
" Tag bar stuff for airline
let g:airline#extensions#tagbar#enabled = 1
au VimEnter * let g:airline_section_x = airline#section#create_right(['tagbar']) | :AirlineRefresh

" marker components to point out the root of a project
let g:rooter_patterns = ['makefile', 'Rakefile', 'gradlew', '.git/']

" Code runner
let g:CodeRunnerCommandMap = {
      \ 'java' : 'javac -Xlint:all $fileName && java -ea $fileNameWithoutExt',
      \ 'python' : 'python3 $fileName',
      \ 'c' : 'clang -std=c11 $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt',
      \ 'cpp' : 'clang++ -std=c++14 $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt',
      \}
let g:code_runner_output_window_size=10

au BufRead *.sql set filetype=mysql

let g:tagbar_vertical=100

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

let g:plantuml_executable_script='/Users/gb/plantuml-custom'

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rls'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }
