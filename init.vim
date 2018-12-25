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

" =============================================================================
" Plugins
" =============================================================================
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
Plug 'nkouevda/vim-thrift-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'mileszs/ack.vim'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'kshenoy/vim-signature' " nice management of marks
Plug 'airblade/vim-rooter'
Plug 'rust-lang/rust.vim'
Plug 'xianzhon/vim-code-runner'
Plug 'metakirby5/codi.vim'
Plug 'luochen1990/rainbow'
Plug 'inside/vim-search-pulse'
call plug#end()

" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = ";"
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>t :TagbarOpenAutoClose<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :make<CR>
nnoremap <Leader>g :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>h :YcmCompleter GetDoc<CR>
nnoremap <Leader>r :YcmCompleter RefactorRename<space>
nnoremap <Leader>u :YcmCompleter GoToReferences<CR>
nnoremap <Leader>j :YcmCompleter GetType<CR>
nnoremap <Leader>a :Ack<Space>-w<Space><cword><CR>
nnoremap <C-j> :wincmd j<CR> 
nnoremap <C-k> :wincmd k<CR> 

" Completion (YCM)
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#000000 guibg=#efefef
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview
let g:ycm_python_binary_path = '/usr/local/bin/python3'

" ALE
let g:ale_fixers = {
\   'java': ['google_java_format'],
\   'c': ['clang-format'],
\   'h': ['clang-format'],
\   'c++': ['clang-format'],
\   'cpp': ['clang-format'],
\   'scala': ['scalafmt'],
\   'ocaml': ['ocamlformat'],
\   'python': ['isort', 'black'],
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
" to stop pep8 based linters from complaining as black uses 88 as line length
let g:ale_python_black_options = '-l 79'
set background=dark

set cursorline
highlight clear CursorLine

if executable('ag')
  " w = match whole words
  let g:ackprg = "ag -w --ignore='*Test*.java' --ignore='*.sql' --ignore='*.htm*' --ignore='*.xml' --vimgrep"
endif

" Go 
let g:go_template_autocreate = 0
let g:go_fmt_autosave = 1

let g:ycm_rust_src_path = '/Users/gb/rust/src'
" Note: this is here purely because I want YCM in markdown+pandoc buffers,
" which are by default blacklisted for some reason.
let g:ycm_filetype_blacklist={'unite': 1, 'tagbar': 1, 'qf': 1, 'vimwiki': 1, 'text': 1, 'infolog': 1, 'mail': 1}
let g:pandoc#modules#disabled = ["folding"]

let g:rustfmt_autosave = 1

" Make airline less cluttered.
let g:airline_section_b='' " vcs info
let g:airline_section_x='' " filetype
let g:airline_section_z='%{line("$")} : %{col(".")}'
" the below denote warnings etc that linters flag. 
let g:airline_section_error='' 
let g:airline_section_warning=''

" make the gutter same colour as lines
highlight clear SignColumn

let g:rooter_patterns = ['Rakefile', 'gradlew', '.git/']

let g:CodeRunnerCommandMap = {
      \ 'java' : 'javac -Xlint:all $fileName && java -ea $fileNameWithoutExt',
      \ 'rust' : 'rustc $fileName && ./$fileNameWithoutExt',
      \ 'python' : 'python3 $fileName',
      \}
let g:code_runner_output_window_size=10

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let g:codi#interpreters = {
                   \ 'python': {
                       \ 'bin': 'python3',
                       \ 'prompt': '^\(>>>\|\.\.\.\) ',
                       \ },
                   \ }

let g:rainbow_active = 1

