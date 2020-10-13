" Specify a directory for plugins
call plug#begin()


" Minimal, sensible defaults
Plug 'tpope/vim-sensible'
" Automatic control structure closing for certain filetypes
Plug 'tpope/vim-endwise'
" Comment out multiple lines specific to file type
Plug 'tpope/vim-commentary'
" Surround text with delimiters
Plug 'tpope/vim-surround'
" git wrapper for vim
Plug 'tpope/vim-fugitive'
" undo tree visualization
Plug 'mbbill/undotree'
" git diff in sign columns
Plug 'mhinz/vim-signify'
" sign column syntax checking
Plug 'vim-syntastic/syntastic'
" virtualenv integration for vim
Plug 'jmcantrell/vim-virtualenv'
" Directory tree visualization
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Suite of tools for tex development.
Plug 'lervag/vimtex'
" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" CTags generation for vim
Plug 'ludovicchabant/vim-gutentags'
" Status window for tab navigation and listing
Plug 'majutsushi/tagbar'

" Initialize plugin system
call plug#end()

" Set tab settings
set shiftwidth=3
set expandtab
set tabstop=3
" Set line numbers
set number

" Enable powerline font symbols for airline and set theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized_flood'
" Various airline configs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#vimtex#enabled = 1
" vimtex specific airline configs
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
" left and right delimiters (shown only when status string is not empty)
let g:airline#extensions#vimtex#left = "{"
let g:airline#extensions#vimtex#right = "}"
" State indicators:
" the current tex file is the main project file
let g:airline#extensions#vimtex#main = ""
" the current tex file is a subfile of the project and the compilation is set for the main file
let g:airline#extensions#vimtex#sub_main = "m"
"the current tex file is a subfile of the project and the compilation is set for this subfile
let g:airline#extensions#vimtex#sub_local = "l"
" single compilation is running
let g:airline#extensions#vimtex#compiled = "c₁"
" continuous compilation is running
let g:airline#extensions#vimtex#continuous = "c"
" viewer is opened
let g:airline#extensions#vimtex#viewer = "v"

" vimtex options
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_fold_enabled = 1
if !exists('g:ycm_semantic_triggers')
   let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" Fold and sign column colours
highlight Folded ctermbg=black
highlight Folded ctermfg=lightyellow
highlight Foldcolumn ctermbg=black
highlight Signcolumn ctermbg=black
highlight DiffAdd ctermbg=black
highlight DiffAdd ctermfg=lightgreen
highlight DiffChange ctermbg=black
highlight DiffChange ctermfg=lightyellow
highlight DiffDelete ctermbg=black
highlight DiffDelete ctermfg=lightred
highlight SpellBad ctermfg=darkred
highlight SpellBad ctermbg=black
highlight SpellBad cterm=bolditalicunderline
set fdc=3

" Syntastic recommended newbie options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" My mappings
" fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
" tagbar
nmap <leader>tb :TagbarOpen fjc<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" local leader
map <Space> <Leader>
" buffer navigation
map gb :bn<cr>
map gB :bp<cr>
" quickfix navigation
map <C-n> :lnext<cr>
map <C-b> :lprevious<cr>

" disable lacheck for syntastic since it fuckin sucks
let g:syntastic_tex_checkers = ["chktex"]
