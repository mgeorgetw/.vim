set shell=/usr/local/bin/fish
set nocompatible              " be iMproved, required

" Initiate plugins {{{
    " Set the runtime path to include Vundle and initialize
    filetype off                  " required

    " Automatically install vim-plug
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    call plug#begin('~/.vim/plugged')
    " Plugins go here
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mileszs/ack.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'mbbill/undotree'
    Plug 'reedes/vim-litecorrect'
    Plug 'reedes/vim-wordy'
    Plug 'mattn/webapi-vim'
    Plug 'tpope/vim-commentary'
    Plug 'majutsushi/tagbar'
    Plug 'godlygeek/tabular'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mattn/gist-vim'
    Plug 'yssource/python.vim'
    Plug 'elzr/vim-json'
    Plug 'groenewege/vim-less'
    Plug 'pangloss/vim-javascript'
    Plug 'jelera/vim-javascript-syntax'
    Plug 'isruslan/vim-es6'
    Plug 'mxw/vim-jsx'
    Plug 'kchmck/vim-coffee-script'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'gorodinskiy/vim-coloresque'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-markdown'
    Plug 'w0rp/ale'
    Plug 'nikvdp/ejs-syntax'
    Plug 'scrooloose/nerdtree'
    Plug 'chrisbra/Colorizer'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'vim-scripts/applescript.vim'
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'
    Plug 'tpope/vim-fugitive'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'suy/vim-context-commentstring'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " All Plugins must be added before the following line
    call plug#end()
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
    let g:user_emmet_leader_key=','
    let g:user_emmet_settings = {
    \   'javascript.jsx' : {
    \       'extends' : 'jsx',
    \   },
    \}

    " CoC - Intellisense
    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"  }}}

" Editing {{{
    set encoding=utf-8
    set virtualedit=all
    au FileType crontab setlocal bkc=yes  " enable saving crontab file
    " Disable IME when switching to normal mode. Does not work with NeoVim
    set noimdisable
    autocmd! InsertLeave * set imdisable|set iminsert=0
    autocmd! InsertEnter * set noimdisable|set iminsert=0
    autocmd BufEnter * silent! lcd %:p:h
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

    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      " Enable file type detection
      filetype on

      " Syntax of these languages is fussy over tabs Vs spaces
      autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

      " Customisations based on house-style (arbitrary)
      autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType javascript setlocal ts=2 sts=2 sw=2 noexpandtab
      autocmd FileType javascript.jsx setlocal ts=2 sts=2 sw=2 noexpandtab

      " Treat .rss files as XML
      autocmd BufNewFile,BufRead *.rss setfiletype xml
      autocmd BufNewFile,BufRead *.txt setfiletype markdown
    endif

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
    set splitbelow          " More natural split opening
    set splitright

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
    " Search for visually selected text
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
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

    " Easymotion
    map <leader> <Plug>(easymotion-prefix)
    " <Leader>f{char} to move to {char}
    map  <leader>f <Plug>(easymotion-bd-f)
    nmap <leader>f <Plug>(easymotion-overwin-f)

" }}}

" Shortcuts {{{
    " map ;; to Esc
    map! ;; <Esc>

    " Set system keyboard as default
    set clipboard=unnamed
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
    "nnoremap <C-W> :bd<CR>

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

    " Ale basic settings
    let g:airline#extensions#ale#enabled = 1  " Set this. Airline will handle the rest.
    let g:ale_completion_enabled = 1
    let g:ale_fixers = {
    \   'javascript': ['prettier', 'eslint'],
    \   'typescript': ['prettier', 'tslint'],
    \   'vue': ['eslint'],
    \   'scss': ['prettier'],
    \   'css': ['prettier'],
    \   'html': ['prettier'],
    \   'reason': ['refmt'],
    \   'python': ['autopep8'],
    \}
    let g:ale_linters = {
    \   'python': ['flake8', 'pylint'],
    \   'javascript': ['eslint'],
    \   'vue': ['eslint']
    \}
    let g:ale_sign_error = '●' " Less aggressive than the default '>>'
    let g:ale_sign_warning = '.'
    let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
    " Set this variable to 1 to fix files when you save them.
    let g:ale_fix_on_save = 1

    " Omni Completion settings
    "set omnifunc=syntaxcomplete#Complete
    "set omnifunc=ale#completion#OmniFunc
    "set completeopt=menu,preview,noselect,noinsert

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
