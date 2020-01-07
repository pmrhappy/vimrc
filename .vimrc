function! UpdateCscope()
    if filereadable(getcwd()."/cscope.out")
        cs kill 0
        !cscope -Rbq
        cs add cscope.out
    endif
endfunction

augroup user_autocmd
    " clear all autocmd while (re)loading
    autocmd!

    autocmd BufWritePost /mnt/* !synas %:p
    autocmd FileType cpp,c,h,hpp,yml,yaml setlocal ts=4 sts=4 sw=4
    "autocmd BufWritePost /mnt/* !updear %:p

    " if cscope.out exists, update it while saving files
    autocmd BufWritePost /mnt/*.py silent! ![ -f cscope.out ] && pycscope -R &
    "autocmd BufWritePost /mnt/*.cpp,/mnt/*.h silent call UpdateCscope()
augroup END

" [Will make ctrlP Fail] clear all mapping while (re)loading
"mapclear | mapclear <buffer> | mapclear! | mapclear! <buffer>

set number
set t_Co=256
syntax on
colorscheme torte

"" change highlight color
hi Search cterm=NONE ctermfg=lightgreen ctermbg=darkyellow
set cursorline
hi CursorLine cterm=none ctermbg=darkblue
set cursorcolumn
"hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White
"set runtimepath^=~/.vim/bundle/ctrlp.vim

" show specail chars
set listchars=tab:..
set list

set colorcolumn=80
hi colorcolumn ctermbg=87ff87
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
:silent! cs add cscope.out
nmap <C-\> :noh<CR>
nmap <F2> :so $MYVIMRC<CR>
nmap <F3> :tabe $MYVIMRC<CR>
nmap <F4> :call UpdateCscope()<CR>
nmap <F6> :!synas %:p<CR>

" json formatter
nmap <C-j> :%!python -m json.tool<CR> \| :noh<CR>

" XML formatter
cmap xmlf<CR> :%!xmllint --format -<CR>

" python dict_str to json formatter
cmap dj<CR> :%s/\n//g<CR> \| !%~/scripts/dict_str_to_json<CR> \| :noh<CR>

" python json to yaml formatter
cmap jy<CR> :%!~/scripts/json_to_yaml<CR> \| :noh<CR>

" python yaml to json formatter
cmap yj<CR> :%!~/scripts/yaml_to_json<CR> \| :noh<CR>

" Python Traceback formatter
cmap pt<CR> :%s/\n//g \| %s/File/\rFile/g \| %s/    /\r    /g<CR> \| :noh<CR>

" close current tab
cmap qt<CR> :tabclose<CR>

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
Plug 'guns/xterm-color-table.vim'
Plug 'AndrewRadev/linediff.vim'

"" These two markdown-relative plugins cannot be used in docker
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

Plug 'tpope/vim-fugitive'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"" for vim-signature
highlight SignColumn ctermbg=8

nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <F5> :NERDTree<CR>
"let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeShowHidden=1
nnoremap <S-Tab> :tabnext<CR>
nnoremap <Leader><Tab> :tabprevious<CR>
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
nnoremap * *``

let cpp_types="c,cpp,h,hpp"
" a / needs \\ to escape because the first one is used for variable,
" second is for autocmd
let cpp_mark_macro=" ?  :s/^/\\/\\//g<CR> /goal_of_life <CR>:<Esc>"
let cpp_unmark_macro=' " :s/^\/\///g<CR> /goal_of_life <CR>:<Esc>'
"" COMMENTING
autocmd bufenter *.py map ?  :s/^/#<CR> /只好去旁邊畫圈圈 <CR>:<Esc>
autocmd bufenter .vimrc map ?  :s/^/"<CR> /  <CR>:<Esc>
execute "autocmd FileType " . join([g:cpp_types, " map ", g:cpp_mark_macro])

" UNCOMMENTING
autocmd bufenter *.py map " :s/^#/<CR> /找別人幫忙找辣 <CR>:<Esc>
autocmd bufenter .vimrc map "  :s/^"/<CR> /  <CR>:<Esc>
execute "autocmd FileType " . join([g:cpp_types, " map ", g:cpp_unmark_macro])

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
    nmap <C-g> :cs find f <C-R>=expand("<cword>")<CR><CR>
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


""for Plugin iamcco/markdown-preview.vim
let g:mkdp_path_to_chrome = "google-chrome --no-sandbox"
" Path to the chrome or the command to open chrome (or other modern browsers).
" If set, g:mkdp_browserfunc would be ignored.

let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" Callback Vim function to open browser, the only parameter is the url to open.

let g:mkdp_auto_start = 0
" Set to 1, Vim will open the preview window on entering the Markdown
" buffer.

let g:mkdp_auto_open = 0
" Set to 1, Vim will automatically open the preview window when you edit a
" Markdown file.
noh
