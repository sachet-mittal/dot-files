"set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/nerdtree'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'kien/ctrlp.vim'
Bundle 'ggreer/the_silver_searcher'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Plugin 'tmhedberg/SimpylFold'

filetype plugin indent on
augroup vimrc_autocmds
     autocmd!
     " highlight characters past column 120
     autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
     autocmd FileType python match Excess /\%120v.*/
     autocmd FileType python set nowrap
     augroup END
" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2


map <F2> :NERDTreeToggle<CR>
" Python-mode
" Activate rope For now deacitvated
" Keys
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0


" Other settings
" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
" automatically change window's cwd to file's dir
set autochdir

" I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" more subtle popup colors
if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif



" Siver Search settings
let g:ackprg = 'ag --nogroup --nocolor --column'


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic setup
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


"" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" Execute Python when saving
" autocmd BufWritePost * !python <afile>
"
autocmd BufWritePre *.py :%s/\s\+$//e


" Reselect visual block after indent/outdent
"
xnoremap < <gv
xnoremap > >gv

" Make :w act same as :w
cnoreabbrev W w

" Comment/uncomment lines :start,end Cm
command -range Cm <line1>,<line2>s/^/#/
command -range Uc <line1>,<line2>s/^#//
cnoreabbrev cm Cm
cnoreabbrev uc Uc


" Insert import pdb; pdb.set_trace() by keystroke \p
map <Leader>p :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal o".trace
endfunction

" SimplIFold configuration
"
" to enable previewing of your folded classes' and functions' docstrings in
" the fold text,
let g:SimpylFold_docstring_preview = 1

" to not  see your docstrings folded
let g:SimpylFold_fold_docstring = 0

" to not see your your imports folded
let g:SimpylFold_fold_import = 0

autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" Case insensitive search
set ignorecase

" Strip training whitespaces on exit
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.yaml :%s/\s\+$//e

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Running python code form inside vim by pressing F9
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
