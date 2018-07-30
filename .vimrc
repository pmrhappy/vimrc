set number
set t_Co=256
colorscheme koehler
set cursorline
"hi CursorLine cterm=none ctermbg=5f00ff ctermfg=White
set cursorcolumn
"hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White
"set runtimepath^=~/.vim/bundle/ctrlp.vim

set colorcolumn=80
set mouse=a
set ruler
set smartcase
set ignorecase
set hlsearch
set cindent
set autoindent
set smartindent
set expandtab
set nobackup
set scrolloff=7
"set scrolljump=5
set incsearch
set nowrap
set encoding=utf-8
cs add cscope.out
nmap <C-\> :noh<CR>
" json formatter
nmap <C-j> :%!python -m json.tool<CR> \| :noh<CR>

" python dict_str to json formatter
cmap dj<CR> :%s/\n//g<CR> \| !%~/scripts/dict_str_to_json<CR> \| :noh<CR>

" Python Traceback formatter
:cmap pt<CR> :%s/\n//g \| %s/File/\rFile/g \| %s/    /\r    /g<CR> \| :noh<CR>

"autocmd BufWritePost /mnt/* !synas %:p
"autocmd BufWritePost /mnt/* !updear %:p

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
"Plug 'vim-scripts/cscope.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'mhinz/vim-signify'
"Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'kshenoy/vim-signature'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"" for vim-signature
highlight SignColumn ctermbg=8

nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <F5> :NERDTree<CR>
"colorscheme torte
"let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeShowHidden=1
nnoremap <S-Tab> :tabnext<CR>
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
nnoremap * *``

"" COMMENTING
autocmd bufenter *.py nmap ?  :s/^/#<CR> /只好去旁邊畫圈圈 <CR>:<Esc>
autocmd bufenter *.h nmap  ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.c nmap  ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.cpp nmap ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.cpp nmap ?  :s/^/\/\/<CR> :let @/ = ""<CR><Esc>
" COMMENTING
autocmd bufenter *.py vmap ? :s/^/#<CR> /怪我囉? <CR>:<Esc>
autocmd bufenter *.h vmap ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.c vmap ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.cpp vmap ?  :s/^/\/\/<CR> /goal_of_life <CR>:<Esc>

" UNCOMMENTING
autocmd bufenter *.py nmap " :s/^#/<CR> /找別人幫忙找辣 <CR>:<Esc>
autocmd bufenter *.c nmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.cpp nmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.h nmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>
" UNCOMMENTING IN .C FILE
autocmd bufenter *.py vmap " :s/^#/<CR> /疑～～～～～ <CR>:<Esc>
autocmd bufenter *.c vmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.cpp vmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>
autocmd bufenter *.h vmap  " :s/^\/\///<CR> /goal_of_life <CR>:<Esc>

let b:ale_linters = {'Python': ['prospector']}
"let b:ale_linters = {'Python': ['flake8']}

"" for cscope
if has("cscope")
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
    nmap <C-a> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-d> :cs find 1 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-f> :cs find 2 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-c> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-x> :cs find 4 <C-R>=expand("<cword>")<CR><CR>
    nmap <C-i> :cs find 8 <C-R>=expand("%:t:r")<CR><CR>
endif


""for Plugin 'scrooloose/syntastic'
"let g:syntastic_python_checkers = ['flake8'] ", 'pylint']
"nmap <F9> :lclose<CR>
""let g:syntastic_python_checkers = ['prospector']
"let g:syntastic_python_python_use_codec = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 1
"let g:syntastic_error_symbol = "✗"
"let g:syntastic_warning_symbol = "⚠"
