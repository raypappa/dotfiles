"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
set nocompatible

" temporarily ft off
filetype off
" Vundle stuf
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle/plugins')
" Package manager
Plugin 'VundleVim/Vundle.vim'

" Fugitive is the premier Vim plugin for Git
" :G
Plugin 'tpope/vim-fugitive'

" A Vim plugin to visualizes the Vim undo tree.
Plugin 'simnalamburt/vim-mundo'

" Sane defaults
Plugin 'tpope/vim-sensible'

" Easy alignment of strings with delimters
" :EasyAlign =
Plugin 'junegunn/vim-easy-align'

"  Check syntax in Vim asynchronously and fix files, with Language
"  Server Protocol (LSP) support
Plugin 'dense-analysis/ale'

" Configurable and extensible tab line and status line
Plugin 'tpope/vim-flagship'

"  The ultimate snippet solution for Vim. Send pull requests to
"  SirVer/ultisnips!
Plugin 'SirVer/ultisnips'

" This repository contains snippets files for various programming
" languages.
Plugin 'honza/vim-snippets'

" json pretty printing and manipulation
Plugin 'tpope/vim-jdaddy'

"  surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more
"  with ease
Plugin 'tpope/vim-surround'

" file browser sorta
" -
Plugin 'tpope/vim-vinegar'

" I make so many Vim plugins I had to make a Vim plugin for making Vim
" plugins.
Plugin 'tpope/vim-scriptease'

" json path navigation
" Do i need this if i have jdaddy?
Plugin 'mogelbrod/vim-jsonpath'

" A multi-language debugging system for Vim
Plugin 'puremourning/vimspector'


" JS/TS
Plugin 'leafgarland/typescript-vim'

" Python
Plugin 'fs111/pydoc.vim'
Plugin 'andviro/flake8-vim'
Plugin 'tell-k/vim-autoflake'
Plugin 'fisadev/vim-isort'
Plugin 'ambv/black'

" Support for running terraform commands
Plugin 'hashivim/vim-terraform'

" more json support?
Plugin 'elzr/vim-json'

" Markdown
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'iamcco/markdown-preview.nvim'

" Not compatible with neovim
" Plugin 'govim/govim'

" Rust
Plugin 'rust-lang/rust.vim'

" Completion framework
Plugin 'hrsh7th/nvim-cmp'
Plugin 'hrsh7th/cmp-buffer'
" snippet stuff
Plugin 'quangnguyen30192/cmp-nvim-ultisnips'
" support signatures

Plugin 'ray-x/lsp_signature.nvim'
" LSP All the things
Plugin 'williamboman/mason.nvim'
Plugin 'williamboman/mason-lspconfig.nvim'
Plugin 'neovim/nvim-lspconfig'

" LSP completion
Plugin 'hrsh7th/cmp-nvim-lsp'
" inlay hints, extra features of rust-analyzer
Plugin 'simrat39/rust-tools.nvim'

Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" fuzzy finder file, buffer, mru, tags
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore', 'package.json', 'pyproject.toml']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

lua require("lsp-config")
let g:rustfmt_autosave = 1

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

lua require("cmp-config")
lua require("organizeImports-config")

autocmd BufWritePre *.go lua OrgImports(1000)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
syntax on
filetype on " done with Vundle, turn it back on
filetype plugin indent on

" I like these.
set softtabstop=2
set shiftwidth=2
set tabstop=2
set textwidth=72
set expandtab
" set tabstop=3
" set shiftwidth=3

" Avoid command-line redraw on every entered character by turning off Arabic
" shaping (which is implemented poorly).
if has('arabic')
	set noarabicshape
endif



" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" I don't want vim mouse integrations.
" set mouse=""
" I might want them for go lang hints?
" In fact, you can hold shift to disable mouse integration now, so you
" can still copy/paste out of vim like it was a normal terminal!
"
"
" Settings for govim/inspired by/etc.
" See
" https://github.com/govim/govim/blob/main/cmd/govim/config/minimal.vimrc
set mouse=a

" nvim doesn't have ttymouse
if exists(':ttymouse')
  set ttymouse=sgr
endif

" This may be plugin dependent
if exists(':balloondelay')
  set balloondelay=250
endif

set updatetime=100

if has("patch-8.1.1904") || has('nvim')
  set completeopt+=menuone,noinsert,noselect
endif

if has("patch-8.1.1904")
  set completepopup=align:menu,border:off,highlight:Pmenu
endif

" This is more generic but still found doing golang stuff so
" Remapt C-x (switch to completion mode) C-o
inoremap <C-@> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>
" This is for terminals that use null for C-space.
" End govim stuff

" autoindent makes life easier.
set autoindent
" Running into some problems with comment indentation
set cindent
set cinkeys-=0#

" I really really hate supertab.
let complType="no"

" I *really* want to highlight search matches.
set hlsearch

" color default

" I have no idea why backups aren't on by default
" Enable tree-undo, and backups in a private backup directory so we don't annoy
" me when working in git.
set backup
set backupdir=~/.vim/backup/
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '-' . strftime("%s")


" Like missing backups, no idea why the hell there's no undodir/undofile
set undodir=~/.vim/undo
set undofile

" I like mundo, and it's GPL2 so I can use it here!
nnoremap <F5> :MundoToggle<CR>


" Set a colorscheme... and use truecolor.
" For some reason tgc isn't working right on macos? Investigate more
" later.
" set termguicolors
" disable background theme color - use terminal
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
" colorscheme flattened_dark
colorscheme OceanicNextTD


" I like vim-easy-align over Align/AlignMap.
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Handle the bulk of folding settings in ftplugins....
let ruby_foldable_groups='def #'
" So I want indent-based folds, but I also want to manually mark folds
" set fen " foldenable
" " set foldlevelstart=4 " Don't fold everything..
" " set foldmethod=indent
" augroup foldsetting
"     autocmd!
"     " au BufReadPre * setlocal foldmethod=indent
"     " au BufWinEnter * setlocal foldmethod=indent | if &fdm == 'indent' | setlocal foldmethod=manual | endif
"     au BufNewFile,BufRead * if (&ft == 'ruby' ||  &ft == 'python') | setlocal foldmethod=syntax | endif
"     " au BufWinEnter * setlocal foldmethod=indent
"     " au BufWinEnter * setlocal foldmethod=manual
" augroup END

" set fen
" Try to fix truecolor through screen
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" I want to look in parent directories for ctags.
set tags=tags;


" Rubocop changes files for me, it pisses me off. This attempts to
" piss me off less
" There was originally a bunch of shit for built-in autoread here, but
" I finally found a plugin that does it better
augroup AutoReading
    autocmd!
    set autoread
    :au CursorMoved * checktime
augroup END

" Vim needs a good statusline
set laststatus=2
set showtabline=2
set guioptions-=e
set statusline=
" I want line numbers.
set ruler

" Default line wrapping options - wrap to 80 cols, on by default.
set textwidth=72
set wrapmargin=80
" Wrap text by default
"set formatoptions+=t

" " Highlight all characters past 74th so we can see long lines
" Actually, there's a vim thing for this now.
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%74v.*/
" augroup END
set colorcolumn=80

" Bleh. Apparently this is a thing now.
" On MacOS, this was getting set to "". Also, setting it fixed absurdly slow
" vim startup... No idea why.
set backspace=indent,eol,start
set relativenumber


" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="vertical"

" If you want :UltiSnipsEdit to split your window.
" au! UltiSnips_AutoTrigger
"
" YAML linting~
let g:syntastic_yaml_checkers = ['yamllint']
"
"
" Some bindings for json comprehending
au FileType json noremap <buffer> <silent> <leader>d :call jsonpath#echo()<CR>
au FileType json noremap <buffer> <silent> <leader>g :call jsonpath#goto()<CR>

" Some bindings for vimspector
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

let g:ale_fixers = {
   \'typescript': ['prettier', 'eslint', 'tsserver', 'cspell'],
   \'javascript': ['prettier', 'eslint', 'tsserver', 'cspell'],
   \'python': ['black', 'isort', 'cspell'],
   \'*': ['remove_trailing_lines', 'trim_whitespace'],
   \}


let g:npm_background = 1
