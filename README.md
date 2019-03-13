# A Vim Configuration

## Main Usage

This configuration mostly runs on [MacVim](https://github.com/macvim-dev/macvim) to deal with JavaScript, Node.js, Python and Markdown. Here's how to apply the settings:

1. This folder belongs in home directory `~/.vim`

2. Download and [install Vundle](https://github.com/VundleVim/Vundle.vim#quick-start) (a Vim plugin manager)
3. Launch `vim` and run `:PluginInstall`

## Styles

![Left: PaperColor; Right: Tomorrow Night](https://dcfwwf2zu3i1a.cloudfront.net/vim_papercolor_and_tomorrownight-20190313.png)

### Font

PragmataPro Regular, available [here](https://www.fsd.it/shop/fonts/pragmatapro/).

### Auto Dark Mode

Not really automatic. But when macOS Mojave is in Dark Mode, Vim launches with a dark color scheme — [Tomorrow Night](https://github.com/chriskempson/tomorrow-theme), along with [Airline's dark theme](https://github.com/vim-airline/vim-airline-themes). In Light Mode, Vim opens files with [PaperColor](https://github.com/NLKNguyen/papercolor-theme) theme.

### Relative Number

Show relative number in NORMAL mode. This allows me to move quicker between lines.

## Shortcuts

### Leader is `,`

Vim leader makes it easier to trigger oft-used functions. Here are some that I use:

- `,p` / `,n` goes to previous/next buffer.
- `,<space>` un-highlights search results.
- `,c<space>` toggles comment.
- `,s` saves current working session.

### Open in Typora

Type `:Typora` and hit `return` will open current file in my [favorite Markdown editor](https://typora.io).

### Open in Marked 2

If I decide to write in Vim, [`:Marked2`](https://marked2app.com/) helps me see the results.

### Emulate the system clipboard

```vimscript
inoremap <D-v> <ESC>"+pa
vnoremap <D-c> "+y
```

These key mappings allow me to use `⌘-v` and `⌘-c` like I normally do.

## Plugins

- [Vundle](https://github.com/VundleVim/Vundle.vim) manages plugins.
- [vim-airline](https://github.com/vim-airline/vim-airline) enhances status bar.
- [ack.vim](https://github.com/mileszs/ack.vim) searches text fast.
- [vim-surround](https://github.com/tpope/vim-surround) simplifies parentheses, brackets, quotes, XML tags, and more.
- [vim-repeat](https://github.com/tpope/vim-repeat) makes repetitive job as easy as a `.`
- [ctrlp.vim](https://github.com/kien/ctrlp.vim) finds files.
- [vim-easymotion](https://github.com/easymotion/vim-easymotion) helps cursor move really fast.
- [nerdtree](https://github.com/scrooloose/nerdtree) explores file system.
- [Colorizer](https://github.com/lilydjwg/colorizer) shows `#fff` in white.
- [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) completes code.
- [emmet-vim](https://github.com/mattn/emmet-vim) improves HTML & CSS writing.
- [TagBar](http://majutsushi.github.com/tagbar/) outlines code.
- [ALE (Asynchronous Lint Engine)](https://github.com/w0rp/ale) checks syntax.

and many more....
