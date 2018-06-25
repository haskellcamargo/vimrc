" -- ENTRY POINT --

" No vi compatibility necessary
set nocompatible
filetype off

" Initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Add Merlin to runtime path for OCaml omnicompletion
let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" -- PLUGINS --

call vundle#begin()

" Vundle bootstrapping
Plugin 'VundleVim/Vundle.vim'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Editing utilities
Plugin 'mkitt/tabline.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/nerdcommenter'
Plugin 'gavocanov/vim-js-indent'
Plugin 'Yggdroot/indentLine'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-syntastic/syntastic'

" Statistics
Plugin 'wakatime/vim-wakatime'

" NerdTree
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" (Programming) languages support
Plugin 'hsanson/vim-android'
Plugin 'vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'digitaltoad/vim-pug'
Plugin 'tpope/vim-rails'
Plugin 'wavded/vim-stylus'
Plugin 'ianks/vim-tsx'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'alunny/pegjs-vim'
Plugin 'nikvdp/ejs-syntax'
Plugin 'elzr/vim-json'
Plugin 'killphi/vim-ebnf'
Plugin 'hylang/vim-hy'
Plugin 'elixir-editors/vim-elixir'
Plugin 'slashmili/alchemist.vim'
Plugin 'fatih/vim-go'
Plugin 'gkz/vim-ls'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'reasonml-editor/vim-reason-plus'
Plugin 'the-lambda-church/coquille'
Plugin 'uarun/vim-protobuf'

" Colorschemes
Plugin 'flazz/vim-colorschemes'
Plugin 'whatyouhide/vim-gotham'
Plugin 'altercation/vim-colors-solarized'
Plugin 'joshdick/onedark.vim'
Plugin 'rakr/vim-one'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'ashfinal/vim-colors-violet'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'Yggdroot/duoduo'

" Icons
Plugin 'ryanoasis/vim-devicons'

" Daily tasks
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()

" -- EDITOR SETTINGS --

" Use custom separator for inner windows
set fillchars+=vert:\|

" i18n and charset
let lang='en'
set langmenu=en
set encoding=utf8
set ffs=unix,dos,mac

" Ignored folders
set wildignore+=*/node_modules/*,*/dist/*,*/public/*,coverage

" Mouse support
if has('mouse')
  set mouse=a
endif

" Additional runtime files and syntax highlighting
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
filetype plugin indent on
syntax enable

" Improve editing and searching
set backspace=eol,start,indent
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set ai
set si
set wrap
set magic
set history=500
set so=0
set wildmenu
set ruler
set lbr
set tw=500
set nu
set numberwidth=5
set conceallevel=1

" Avoid creating temporary files
set nobackup
set nowb
set noswapfile

" Convert tabs to spaces
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Make arrows work
set ww+=<,>

" Color system and scheme
set termguicolors
colorscheme palenight
set background=dark

" -- AUTOMATIC COMMANDS --

" Load NerdTree
au VimEnter * NERDTree

" Focus on editor instead of NerdTree
au VimEnter * wincmd p

" Kill trailing whitespace on save
au BufWritePre * StripWhitespace

" Convert `.md' files for Markdown instead of Modula 2
au BufRead,BufNewFile *.md set filetype=markdown

" Error messages
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%120v.\+', -1)

" -- KEYBOARD SHORTCUTS --

" Tabs
nnoremap <C-Left> :tabp<CR>
nnoremap <C-Right> :tabn<CR>
nnoremap <C-N> :tabnew<CR>
nnoremap <C-Q> :q<CR>

" Save with <C-S> and update git gutter
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
                           \|:GitGutter
nnoremap <silent> <C-S> :<C-u>Update<CR>

" -- GUI SETTINGS --

" NerdTree
let g:NERDTreeMinimalUI = 1
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeIgnore=['node_modules', 'dist', 'public', 'coverage']

" Syntastic
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_mode_map={'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\uf071"

" WebDevIcons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Syntastic
hi SyntasticErrorLine ctermbg=161
hi SyntasticErrorSign ctermbg=161 ctermfg=White cterm=Bold
hi SyntasticWarningSign ctermbg=178 ctermfg=White cterm=Bold

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'violet'
let g:airline#extensions#syntastic#error_symbol = "\u2717"
let g:airline#extensions#syntastic#warning_symbol = "\uf071"
let g:airline#extensions#syntastic#stl_format_err = ' %e'
let g:airline#extensions#syntastic#stl_format_warn = ' %w'
let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '%p%%'])
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . " \uE0A3" . '%{col(".")}'])

" Tabs
hi TabLine guibg=#333333 guifg=#CCCCCC
hi TabLineSel guibg=#2980B9 guifg=#FFFFFF cterm=Bold

" Highlight current line number
set cursorline
hi CursorLineNr cterm=Bold guibg=#333333

" Omit '~'
highlight NonText ctermfg=bg guifg=bg

" Indent guides (with indent line)
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#2C3E50'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

" Git gutter symbols and colors
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_modified = '~~'
hi GitGutterAdd ctermfg=34 ctermfg=White guifg=#FFFFFF guibg=#2ECC71 cterm=Bold
hi GitGutterDelete ctermbg=161 ctermfg=White guifg=#FFFFFF guibg=#E74C3C cterm=Bold
hi GitGutterChange ctermbg=32 ctermfg=White guifg=#FFFFFF guibg=#2980B9 cterm=Bold

" -- LANGUAGE SETTINGS --

" Haskell
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1

" JavaScript
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
