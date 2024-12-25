" Vundle {{{
  set nocompatible
  filetype off

  set rtp+=~/.dotfiles/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'

  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'ervandew/supertab'
  Plugin 'godlygeek/tabular'
  Plugin 'maxbrunsfeld/vim-yankstack'
  Plugin 'mileszs/ack.vim'
  Plugin 'morhetz/gruvbox'
  Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'scrooloose/nerdtree'
  Plugin 'sheerun/vim-polyglot'
  Plugin 'terryma/vim-multiple-cursors'
  Plugin 'thinca/vim-visualstar'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-commentary'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-markdown'
  Plugin 'tpope/vim-ragtag'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-rhubarb'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-vinegar'
  Plugin 'vim-airline/vim-airline'
  Plugin 'w0rp/ale'
  Plugin 'zhaocai/GoldenView.Vim'

  call vundle#end()
" }}}

" General {{{
  filetype plugin indent on
  syntax on
  set mouse=a                                 " enable the use of the mouse in all modes
  if !has('nvim')
    set ttymouse=xterm2                       " and we want it to be fast
  endif
  set encoding=utf-8                          " sets the character encoding used inside Vim
  set clipboard^=unnamedplus,unnamed
  set hidden                                  " allow backgrounding buffers without writing them
  set timeout timeoutlen=1000 ttimeoutlen=10  " fix delay after pressing ESC
  set autoread                                " auto reload buffer if file has been changed
  set nobackup                                " disable backup files...
  set noswapfile                              " and swap files
  runtime macros/matchit.vim
" }}}

" VIM UI {{{
  color gruvbox
  colorscheme gruvbox
  " let g:rehash256 = 1
  let g:gruvbox_contrast_dark='hard'
  " let g:airline_theme='gruvbox'
  set background=dark

  set cursorline                  " highlight the screen line of the cursor
  set noshowmode                  " do not show vim mode in the last line of the screen
  set showcmd                     " show (partial) command in the last line of the screen
  set number                      " precede each line with its line
  set backspace=indent,eol,start  " backspace through everything in insert mode
  set laststatus=2                " always show a status line

  set incsearch  " incremental searching
  set hlsearch   " highlight matches
  set ignorecase " searches are case insensitive...
  set smartcase  " unless they contain at least one capital letter

  set wildmenu                    " enable command-line completion
  set wildmode=list:longest,full  " autocompletion shouldn't jump to the first match
  set wildignore+=.git/**,.svn/**,.sass-cache/**,tmp/**,node_modules/**

  set scrolljump=5 " minimal number of lines to scroll when the cursor gets off the screen
  set scrolloff=5  " minimal number of screen lines to keep above and below the cursor
  set splitright   " puts new vsplit windows to the right of the current
  set splitbelow   " puts new split windows to the bottom of the current

  set list                                       " show invisible characters
  set listchars=""                  " reset the listchars
  set listchars=tab:▸\ ,eol:¬       " a tab should display as "▸ ", end of lines as "¬"
  set listchars+=trail:.            " show trailing spaces as dots
  set listchars+=extends:>          " the character to show in the last column when wrap is
                                    " off and the line continues beyond the right of the screen
  set listchars+=precedes:<         " the character to show in the first column when wrap is
                                    " off and the line continues beyond the left of the screen
  set fillchars+=vert:\             " set vertical divider to empty space
" }}}

" Formatting {{{
  set nowrap                      " do not wrap long lines
  set autoindent                  " indent at the same level of the previous line
  set shiftwidth=2                " use indents of 2 spaces
  set expandtab                   " tabs are spaces, not tabs
  set tabstop=2                   " an indentation every 2 columns
  set softtabstop=2               " let backspace delete indent
  set nojoinspaces                " prevents inserting two spaces after punctuation on a join (J)
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

  set foldmethod=syntax
  set foldnestmax=10
  set nofoldenable
  set foldlevel=2

  if has("autocmd")
    " make sure all markdown files have the correct filetype set and setup wrapping
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

    " treat JSON files like JavaScript
    au BufNewFile,BufRead *.json setf javascript

    " spree deface support
    au BufNewFile,BufRead *.html.erb.deface setf eruby
    au BufNewFile,BufRead *.html.slim.deface setf slim
    au BufNewFile,BufRead *.js.coffee.erb setf coffee

    " delete Fugitive buffers when they become inactive
    au BufReadPost fugitive://* set bufhidden=delete

    " remember last location in file, but not for commit messages,
    " or when the position is invalid or inside an event handler,
    " or when the mark is in the first line, that is the default
    " position when opening a file. See :help last-position-jump
    au BufReadPost *
      \ if &filetype !~ '^git\c' && line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  endif
" }}}

" General mappings {{{
  let mapleader=","

  " disable man page for word under cursor
  nnoremap K <nop>

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Bad behaviours
  xnoremap u <Nop>

  " Copy buffer path in clipboard
  nnoremap cp :let @+=expand('%')<CR>
  nnoremap cap :let @+=expand('%:p')<CR>

  " clear the search buffer when hitting return
  nnoremap <CR> :nohlsearch<CR>

  " expand %% to current directory
  cnoremap %% <C-R>=expand('%:h').'/'<CR>

  " edit file in the same directory of current file
  map <Leader>e :e %%

  " easy way to switch between latest files
  nnoremap <Leader><Leader> <C-^>

  " easy substitutions
  nmap <Leader>r :%s///gc<Left><Left><Left><Left>
  nmap <Leader>R :%s:::gc<Left><Left><Left><Left>

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " easier navigation between split windows
  nnoremap <C-J> <C-W>j
  nnoremap <C-K> <C-W>k
  nnoremap <C-H> <C-W>h
  nnoremap <C-L> <C-W>l


  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " Mastering VIM Quickly
  nmap <F2> :!git shortlog HEAD -s -n %<cr>
" }}}

" Commands and functions {{{
  " Convert hashrockets into new 1.9 hash syntax
  command! ConvertRubyHash :normal :%s/:\(\w\+\)\s*=>/\1:/ge<CR><C-O><CR>

  " remove whitespaces and windows EOL
  command! KillWhitespace :normal :%s/\s\+$//e<CR><C-O><CR>
  command! KillControlM :normal :%s/<C-V><C-M>//e<CR><C-O><CR>
" }}}

" Plugins Configuration {{{
    let g:goldenview__enable_default_mapping = 0

  " CtrlP {{{
    let g:ctrlp_map = '<leader>f'
  " }}}

  " Ack {{{
    " easy global search
    " need to write `stty -ixon` in your bashrc
    nnoremap <C-S> :Ack <C-R><C-W><CR>
    vnoremap <C-S> y<Esc>:Ack '<C-R>"'<CR>
    if executable('rg')
      let g:ackprg = 'rg --hidden --vimgrep'
    endif
  " }}}

  " Yankstack {{{
    nmap <C-p> <Plug>yankstack_substitute_older_paste
    nmap <C-n> <Plug>yankstack_substitute_newer_paste
    let g:yankstack_map_keys = 0
  " }}}

  " NERDtree {{{
    map <Leader>n :NERDTreeToggle<CR>
    let g:NERDTreeMouseMode = 3
    let g:NERDTreeHighlightCursorline = 0
  " }}}

  " airline {{{
    let g:airline_left_sep='›'
    let g:airline_right_sep='‹'
    let g:airline_powerline_fonts = 0
  " }}}

  " indent guides {{{
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
  " }}}

  " ale
    let g:airline#extensions#ale#enabled = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_insert_leave = 0
    let g:used_javascript_libs = 'vuejs'
    let g:ale_ruby_rubocop_executable = 'bundle'
    let g:ale_linters = { 'ruby': ['ruby', 'rubocop', 'reek'] }
  " }}}

  " tpope-vimragtag
    inoremap <M-o>       <Esc>o
    inoremap <C-j>       <Down>
    let g:ragtag_global_maps = 1
  " }}}

" }}}

" Abbrevations {{{
  cabbrev ACk Ack
  cabbrev ACK Ack
  iabbrev lenght length
  iabbrev ligth light
" }}}

" vim: foldmarker={{{,}}} foldlevel=0 foldmethod=marker
