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
" Syntax checking for various filetypes.
Plug 'vim-syntastic/syntastic'
" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Initialize plugin system
call plug#end()

" Set tab width
set shiftwidth=3
" Set line numbers
set number
" Enable powerline font symbols for airline and set theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized_flood'

let g:vimtex_compiler_progname = 'nvr'
