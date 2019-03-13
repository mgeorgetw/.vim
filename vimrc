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
    Plugin 'vim-scripts/sessionman.vim'
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
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'NLKNguyen/papercolor-theme'
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
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
    let g:ctrlp_user_command = 'find %s -type f'  " MacOSX/Linux

    " NERDTree
    let NERDTreeShowHidden=1

    " Lite correct
    augroup litecorrect
      autocmd!
      autocmd FileType markdown,mkd call litecorrect#init()
      autocmd FileType textile call litecorrect#init()
    augroup END

    " Toggle Undotree
    nnoremap <F5> :UndotreeToggle<cr>

    " Toggle Tagbar
    nmap <F8> :TagbarToggle<CR>
" }}}

" Editing {{{
    set encoding=utf-8
    set virtualedit=all
    au FileType crontab setlocal bkc=yes  " enable saving crontab file
" }}}

" Spaces and Tabs {{{
    set tabstop=4       " number of visual spaces per TAB
    set shiftwidth=4
    set softtabstop=4   " number of spaces in tab when editing
    set expandtab       " tabs are spaces
    set backspace=indent,eol,start " make backspace work again
" }}}

" UI Layout {{{
    " Apply GUI font only to MacVim because VimR does not like it.
    if has("gui_macvim")
        set guifont=PragmataPro:h14
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
    " save session
    nnoremap <leader>s :mksession<CR>
    " edit vimrc/zshrc and load vimrc bindings
    nnoremap <leader>ev :vsp $MYVIMRC<CR>
    nnoremap <leader>ef :vsp ~/.config/fish/config.fish<CR>
    nnoremap <leader>so :source Session.vim<CR>
    " shortcut to disable highlight
    nnoremap <leader><space> :nohlsearch<CR>
    " go to the previous/next buffer
    nnoremap <leader>p :bp<CR>
    nnoremap <leader>n :bn<CR>
" }}}

" Shortcuts {{{
    " map ;; to Esc
    map! ;; <Esc>

    " Copy and paste from system clipboard
    map "*y :w !LANG=en_US.UTF-8 pbcopy<CR><CR>
    map "*p :r !LANG=en_US.UTF-8 pbpaste<CR><CR>
    " Emulate the system clipboard
    inoremap <D-v> <ESC>"+pa
    vnoremap <D-c> "+y
    vnoremap <D-d> "+d

    " Use Ctrl-TAB to switch between buffers
    nnoremap <C-TAB> :bn<CR>

    " Prettify JSON file using Python
    nmap =j :%!python -m json.tool<CR>

    " Open current document in Typora
    command Typora :silent !open -a Typora.app '%:p'<cr>
    " Open current document in Marked 2
    command Marked2 :silent !open -a Marked\ 2.app '%:p'<cr>
" }}}

" Syntax {{{
    syntax enable	    " enable syntax processing

    " Ale basic settings
    let g:airline#extensions#ale#enabled = 1  " Set this. Airline will handle the rest.
    let g:ale_completion_enabled = 1
    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'python': ['autopep8']
    \}

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
      if -1 == match(nam, "[\._]src$")
        let minfname = nam.".min.".ext
      else
        let minfname = substitute(nam, "[\._]src$", "", "g").".".ext
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
    autocmd FileWritePost,BufWritePost *.less :call Js_css_compress(" }}}
