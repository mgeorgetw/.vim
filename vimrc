set shell=/bin/bash
set nocompatible              " be iMproved, required

" Initiate plugins {{{
    " Set the runtime path to include Vundle and initialize
    filetype off                  " required
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'mileszs/ack.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tacahiroy/ctrlp-funky'
    Plugin 'rhysd/conflict-marker.vim'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'mbbill/undotree'
    Plugin 'reedes/vim-litecorrect'
    Plugin 'reedes/vim-wordy'
    Plugin 'mattn/webapi-vim'
    Plugin 'tpope/vim-commentary'
    Plugin 'majutsushi/tagbar'
    Plugin 'godlygeek/tabular'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'mattn/gist-vim'
    Plugin 'yssource/python.vim'
    Plugin 'python_match.vim'
    Plugin 'pythoncomplete'
    Plugin 'elzr/vim-json'
    Plugin 'groenewege/vim-less'
    Plugin 'pangloss/vim-javascript'
    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'isruslan/vim-es6'
    Plugin 'mxw/vim-jsx'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'gorodinskiy/vim-coloresque'
    Plugin 'mattn/emmet-vim'
    Plugin 'tpope/vim-markdown'
    Plugin 'w0rp/ale'
    Plugin 'nikvdp/ejs-syntax'
    Plugin 'scrooloose/nerdtree'
    Plugin 'chrisbra/Colorizer'
    Plugin 'NLKNguyen/papercolor-theme'
    Plugin 'vim-scripts/applescript.vim'
    Plugin 'xolox/vim-session'
    Plugin 'xolox/vim-misc'
    Plugin 'tpope/vim-fugitive'
    Plugin 'skywind3000/asyncrun.vim'
    Plugin 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
    let g:prettier#autoformat = 0
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
    " All Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required

    """ Plugin configurations
    " Airline
    let g:airline#extensions#tabline#enabled = 1      " Enable the list of buffers
    let g:airline#extensions#tabline#fnamemod = ':t'  " Show just the filename

    " CtrlP
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(DS_Store|mp3|so|jpg|png|jpeg|swp|swo|swm|swn|swl|nmsv|session|history|historynew|pdf|tiff)$',
    \ }
    let g:ctrlp_user_command = 'find %s -type f'  " MacOSX/Linux
    let g:ctrlp_user_command =
    \ ['.git', 'cd %s && git ls-files -co --exclude-standard']

    " NERDTree
    let NERDTreeShowHidden=1
    let NERDTreeWinSize=30
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowLineNumbers=0

    " vim-markdown
    " Highlight YAML frontmatter of markdown
    let g:vim_markdown_frontmatter=1
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_conceal = 0

    " Lite correct
    " Lightweight auto-correction for Vim
    augroup litecorrect
      autocmd!
      autocmd FileType markdown,mkd call litecorrect#init()
      autocmd FileType textile call litecorrect#init()
    augroup END

    " Emmit
    let g:user_emmet_leader_key='<Tab>'
    let g:user_emmet_settings = {
    \   'javascript.jsx' : {
    \       'extends' : 'jsx',
    \   },
    \}
" }}}

" Editing {{{
    set encoding=utf-8
    set virtualedit=all
    au FileType crontab setlocal bkc=yes  " enable saving crontab file
    " Disable IME when switching to normal mode. Does not work with NeoVim
    set noimdisable
    autocmd! InsertLeave * set imdisable|set iminsert=0
    autocmd! InsertEnter * set noimdisable|set iminsert=0
    " Enable mouse
    if has('mouse')
      set mouse=a
    endif
" }}}

" Spaces and Tabs {{{
    " Use the same symbols as TextMate for tabstops and EOLs
    set listchars=tab:▸\ ,eol:¬
    "Invisible character colors 
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

    set tabstop=4       " number of visual spaces per TAB
    set shiftwidth=4
    set softtabstop=4   " number of spaces in tab when editing
    set expandtab       " tabs are spaces
    set backspace=indent,eol,start " make backspace work again

    " Set tabstop, softtabstop and shiftwidth to the same value
    command! -nargs=* Stab call Stab()
    function! Stab()
        let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
        if l:tabstop > 0
            let &l:sts = l:tabstop
            let &l:ts = l:tabstop
            let &l:sw = l:tabstop
        endif
        call SummarizeTabs()
    endfunction

    function! SummarizeTabs()
        try
            echohl ModeMsg
            echon 'tabstop='.&l:ts
            echon ' shiftwidth='.&l:sw
            echon ' softtabstop='.&l:sts
            if &l:et
                echon ' expandtab'
            else
                echon ' noexpandtab'
            endif
        finally
            echohl None
        endtry
    endfunction

    " Tidying whitespace (http://vimcasts.org/episodes/tidying-whitespace/)
    function! Preserve(command)
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        execute a:command
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction 

    nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
    nmap _= :call Preserve("normal gg=G")<CR>
" }}}

" UI Layout {{{
    " Apply GUI font only to MacVim because VimR does not like it.
    if has("gui_macvim")
        set guifont=PragmataPro:h14
        set antialias
        set gcr+=a:blinkon0
    endif

    colorscheme Tomorrow-Night  " Default theme
    " Choose theme according to Mojave dark mode
    if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
        colorscheme Tomorrow-Night
        let g:airline_theme='dark'
    else
        set background=light
        colorscheme PaperColor
        let g:airline_theme='papercolor'
    endif

    set t_Co=256
    set number              " show line numbers
    set relativenumber      " turn on relative line number
    set showcmd             " show command in bottom bar
    set nocursorline        " do not highlight current line, drastically improves speed
    set wildmenu            " visual autocomplete for command menu
    set showmatch           " highlight matching [{()}]

    " Show relative number in normal mode
    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd BufEnter,FocusLost,InsertEnter * set norelativenumber
    augroup END

    " Cursor changes between modes.
    let &t_SI.="\e[6 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" }}}

" Navigation {{{
    command CWD cd %:p:h    " CWD = Change to Currently working directory
    set autochdir           " working directory is always the same as the file editing
    " toggles nerdtree with Ctrl-E
    nnoremap <C-e> :NERDTreeToggle<CR>
" }}}

" Searching {{{
    set incsearch           " search as characters are entered
    set hlsearch            " highlight matches
    set path+=**            " Search down in subfolders
" }}}

" Folding {{{
    set foldenable          " enable folding
    set foldlevelstart=3    " open most folds by default
    set foldnestmax=10      " 10 nested fold max
    " space open/closes folds
    nnoremap <space> za
    set foldmethod=indent   " fold based on indent level
" }}}

" Movement {{{
    " move vertically by visual line
    nnoremap j gj
    nnoremap k gk
    " highlight last inserted text
    nnoremap gV `[v`]
" }}}

" Leader Shortcuts {{{
    let mapleader=","       " leader is comma
    " edit vimrc/fish and load vimrc bindings
    nnoremap <leader>ev :vsp ~/.vim/vimrc<CR>
    nnoremap <leader>ef :vsp ~/.config/fish/config.fish<CR>
    " reload vim
    nnoremap <leader>rl :so $MYVIMRC<CR>
    " shortcut to disable highlight
    nnoremap <leader><space> :nohlsearch<CR>
    " go to the previous/next buffer
    nnoremap <leader>p :bp<CR>
    nnoremap <leader>n :bn<CR>

    " Save/Open session with vim-session
    nnoremap <leader>ss :SaveSession<space>
    nnoremap <leader>so :OpenSession<space>

    " Toggle invisible characters
    nmap <leader>l :set list!<CR>
" }}}

" Shortcuts {{{
    " map ;; to Esc
    map! ;; <Esc>

    " Copy and paste from system clipboard
    map "*y :w !LANG=en_US.UTF-8 pbcopy<CR><CR>
    map "*p :r !LANG=en_US.UTF-8 pbpaste<CR><CR>
    inoremap <C-v> <ESC>"+pa
    vnoremap <C-c> "*y
    vnoremap <C-x> "*d
    " Emulate the system clipboard(only in MacVim)
    inoremap <D-v> <ESC>"+pa
    vnoremap <D-c> "*y
    vnoremap <D-x> "*d

    " Use Ctrl-TAB to switch between buffers (only in MacVim)
    nnoremap <C-TAB> :bn<CR>
    nnoremap <C-W> :bd<CR>

    " Toggle Undotree
    nnoremap <F5> :UndotreeToggle<cr>

    " Toggle Tagbar
    nmap <F8> :TagbarToggle<CR>

    " Prettify JSON file using Python
    nmap =j :%!python -m json.tool<CR>

    " Open current document in Typora
    command Typora :silent !open -a Typora.app '%:p'<cr>
    " Open current document in Marked 2
    command Marked2 :silent !open -a Marked\ 2.app '%:p'<cr>
" }}}

" Syntax {{{
    syntax enable	    " enable syntax processing

    " Omni Completion settings
    set omnifunc=syntaxcomplete#Complete
    set completeopt=menu,noinsert

    " Ale basic settings
    let g:airline#extensions#ale#enabled = 1  " Set this. Airline will handle the rest.
    let g:ale_completion_enabled = 1
    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'typescript': ['prettier', 'tslint'],
    \   'vue': ['eslint'],
    \   'scss': ['prettier'],
    \   'html': ['prettier'],
    \   'reason': ['refmt'],
    \   'python': ['autopep8']
    \}
    let g:ale_linters = {
    \   'python': ['flake8', 'pylint'],
    \   'javascript': ['eslint'],
    \   'vue': ['eslint']
    \}
    let g:ale_sign_error = '●' " Less aggressive than the default '>>'
    let g:ale_sign_warning = '.'
    let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

    autocmd BufNewFile,BufRead *.scss             set ft=scss.css
" }}}

" Python {{{
    let g:python_host_prog = '/usr/local/bin/python3'
    let g:python2_host_prog = '/usr/local/bin/python2.7'
    let g:python3_host_prog = '/usr/local/bin/python3'
" }}}

" Javascript {{{
    " Enables syntax highlighting for JSDocs.
    let g:javascript_plugin_jsdoc = 1
    " Enables some additional syntax highlighting for NGDocs.
    let g:javascript_plugin_ngdoc = 1
    let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" }}}

" Auto Minification with yuicompressor
" http://vim.wikia.com/wiki/Auto_execute_yuicompressor {{{
    function Js_css_compress ()
        let cwd = expand('<afile>:p:h')
        let nam = expand('<afile>:t:r')
        let ext = expand('<afile>:e')
        if -1 == match(nam, '[\._]src$')
            let minfname = nam.'.min.'.ext
        else
            let minfname = substitute(nam, '[\._]src$', '', 'g').'.'.ext
        endif
        if ext == 'less'
            if executable('lessc')
                cal system( 'lessc '.cwd.'/'.nam.'.'.ext.' &')
            endif
        else
            if filewritable(cwd.'/'.minfname)
                if ext == 'js' && executable('closure-compiler')
                    cal system( 'closure-compiler --js '.cwd.'/'.nam.'.'.ext.' > '.cwd.'/'.minfname.' &')
                elseif executable('yuicompressor')
                    cal system( 'yuicompressor '.cwd.'/'.nam.'.'.ext.' > '.cwd.'/'.minfname.' &')
                endif
            endif
        endif
    endfunction
    autocmd FileWritePost,BufWritePost *.js :call Js_css_compress()
    autocmd FileWritePost,BufWritePost *.css :call Js_css_compress()
    autocmd FileWritePost,BufWritePost *.less :call Js_css_compress()
" }}}
