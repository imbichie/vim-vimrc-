"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim line history
    set history=1000
" mouse for default middle button to copy paste
    set mouse=a
    set mousemodel=popup
" hide the mouse when typing the text
    set mousehide
" always display line number
    set nu

" theme color selection set either dark or light
"    set background=light
    set background=dark

" marginal line number color
    if &background == "dark"
        if !exists("colorscheme_elflord")
            autocmd InsertLeave * highlight LineNr guifg=#FF4444
            "autocmd InsertLeave * highlight CursorLineNr gui=BOLD guifg=BG
        else
            autocmd InsertLeave * highlight LineNr guifg=#FFD700
            "autocmd InsertLeave * highlight CursorLineNr gui=BOLD guifg=BG
        endif
    else
        if !exists("colorscheme_light")
            autocmd InsertLeave * highlight LineNr gui=NONE guibg=White guifg=#FF0000
            "autocmd InsertLeave * highlight CursorLineNr gui=BOLD guibg=#FF0000 guifg=White
        endif
    endif

" turn-off the blinking cursor in normal mode
    "set gcr=n:blinkon0

" cursor color
    if &background == "dark"
        autocmd InsertEnter * highlight Cursor guibg=Cyan guifg=Black
        autocmd InsertLeave * highlight Cursor guibg=Red guifg=Black
        autocmd InsertEnter * highlight ICursor guibg=#C00066 guifg=Black
    else
        autocmd InsertEnter * highlight Cursor guibg=#FF05A0
        autocmd InsertLeave * highlight Cursor guibg=#00FF00 guifg=White
        autocmd InsertEnter * highlight ICursor guibg=#5A00C2 guifg=White
    endif
" cursorline
    set cursorline
    if &background == "dark"
        if !exists("colorscheme_elflord")
            autocmd InsertEnter * highlight CursorLine guibg=#600030
            autocmd InsertLeave * highlight CursorLine guibg=#0000BB
        else
            autocmd InsertEnter * highlight CursorLine guibg=#220000
            autocmd InsertLeave * highlight CursorLine guibg=#334444
        endif
    else
            autocmd InsertEnter * highlight CursorLine guibg=#BBFFBB
            autocmd InsertLeave * highlight CursorLine guibg=#FFAAFF
    endif

" highlight the word under the cursor
    nnoremap w/ :if Toggle_Highlight()<Bar>endif<CR>
    function! Toggle_Highlight()
        let @/ = ''
        if exists('#auto_hl')
            au! auto_hl
            augroup! auto_hl
            setl updatetime=4000
            echo 'Highlight current word: off'
            return 0
        else
            augroup auto_hl
            au!
            autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
            autocmd CursorMovedI * exe printf('match p0 /\V\<%s\>/', escape(expand('<cword>'), '/\'))
            augroup end
            echo 'Highlight current word: ON'
            return 1
        endif
    endfunction

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
    nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
    function! AutoHighlightToggle()
        let @/ = ''
        if exists('#auto_highlight')
            au! auto_highlight
            augroup! auto_highlight
            setl updatetime=4000
            echo 'Highlight current word: off'
            return 0
        else
            augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
            au CursorHoldI * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
            augroup end
            setl updatetime=50
            echo 'Highlight current word: ON'
            return 1
        endif
    endfunction

" vertical split window color
    if &background == "dark"
        autocmd InsertEnter * highlight vertsplit guibg=Black guifg=Yellow
    else
        autocmd InsertEnter * highlight vertsplit guibg=#000050 guifg=#AFAF00
    endif
    "set fillchars+=vert:⁞
    set fillchars+=vert:*

"folded line color
    if &background == "dark"
        if !exists("colorscheme_elflord")
            autocmd InsertLeave * highlight FoldColumn gui=bold guibg=Blue guifg=Red
            autocmd InsertLeave * highlight Folded gui=italic guibg=White guifg=Black
        else
            autocmd InsertLeave * highlight FoldColumn gui=bold guibg=Black guifg=Red
            autocmd InsertLeave * highlight Folded gui=italic guibg=White guifg=Blue
        endif
    else
        autocmd InsertLeave * highlight FoldColumn gui=bold guibg=White guifg=Blue
        autocmd InsertLeave * highlight Folded gui=italic guibg=Black guifg=Red
    endif

" enable filetype plugins
    filetype plugin on
    filetype indent on

" leader maps
" like <leader>w saves the current file
    let mapleader = ","
    let g:mapleader = ","

" fast saving
    nmap <leader>w :w!<cr>
    nmap <leader>q :q<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5 lines to the cursor - when moving vertically using j/k
    set so=5
" turn on wild menu
    set wildmenu
    highlight WildMenu guibg=DarkYellow guifg=Grey
" ignore compiled files
    set wildignore=*.o,*~,*.pyc
" always shoe current position
    set ruler
" to disable the autocomment insertion in next line if the current line is a
" comment
    "autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" height of command bar
    set cmdheight=1
" yank from file to file
    set clipboard=unnamed
" buffer becomes hidden when it is abandoned
    set hid
" ignore case when searching
    set ignorecase
" disable noinfercase
    set infercase
" when searching try to be smart about cases
    set smartcase
" highlight search results
    set hlsearch
" search act like search in modern browser
    set incsearch
" open split on right, not left
    set splitright
" open split on below, not above
    set splitbelow
" regular expressions turn magic on
    set magic
" show matching brackets
    set showmatch
    autocmd InsertEnter * highlight Matchparen guibg=Red guifg=White gui=underline
    autocmd InsertLeave * highlight Matchparen guibg=Red guifg=Yellow gui=underline
" how many tenths of second to blink when a matching brackets
    set mat=4
" current mode in status line
    set showmode
" display as much of the last line as possible if its really long
" also display unprintable characters as hex
    set display+=lastline,uhex
" display the number of characters | lines in visual mode and current command
    set showcmd
" threshold for reporting the number of lines changed in as s/// etc.
    set report=0
" don't want space through things
    set nomore
" no annoying sounds on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500
    set vb t_vb=
" show extra white space in color
    if &background == "dark"
        autocmd InsertEnter * highlight ExtraWhitespace ctermbg=White guibg=White
        autocmd InsertLeave * highlight ExtraWhitespace ctermbg=White guibg=#C0C0C0
    else
        autocmd InsertEnter * highlight ExtraWhitespace ctermbg=Black guibg=Black
        autocmd InsertLeave * highlight ExtraWhitespace ctermbg=Black guibg=#202020
    endif
    autocmd InsertEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" window default size setting
    if &diff
        set wrap
        set lines=45 columns=220
    else
        set lines=45 columns=110
    endif
    "winpos 20 20

" Lines not rendering while scrolling problem solution
" set the ttyscroll to a low number from 0 to 2, etc
"    set ttyscroll=3

" set horizontal line scroll increment
set sidescroll=1
" set the number of text columns to be shown on both sides of the cursor (including empty -or virtual- columns after the cursor position)
set sidescrolloff=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable syntax highlighting
    syntax enable
" highlighting comments in italic
    autocmd InsertEnter * highlight comment gui=ITALIC
" highlighting strings inside C comments
    let c_comment_strings=1
" switch on syntax highlighting if it wasn't on yet
    if !exists("syntax_on")
        syntax on
    endif

" colorscheme
    if &background == "dark"
        colorscheme my_scheme
        "colorscheme elflord
    else
        colorscheme default
    endif
" font
    set guifont=Monospace\ 9
" unused text background color
    if &background == "dark"
        autocmd InsertEnter * highlight NonText ctermbg=Yellow guibg=Grey25 guifg=Cyan
        "highlight SpecialKey guibg=White guifg=Blue
    else
        autocmd InsertEnter * highlight NonText ctermbg=Blue guibg=#C0C0C0 guifg=#0C00E5
        "highlight SpecialKey guibg=Black guifg=Green
    endif

" compare mode color
    if &background == "dark"
        if !exists("colorscheme_elflord")
            highlight DiffAdd cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#66FF66 guifg=bg
            highlight DiffDelete cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#552B49 guifg=#EBF61E
            highlight DiffChange cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#9E9147 guifg=White
            highlight DiffText cterm=NONE ctermbg=88 ctermfg=10 gui=NONE guibg=#FF2020 guifg=bg
        else
            highlight DiffAdd cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#66FF66 guifg=bg
            highlight DiffDelete cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#2020FF guifg=bg
            highlight DiffChange cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#E194FF guifg=White
            highlight DiffText cterm=NONE ctermbg=88 ctermfg=10 gui=NONE guibg=Red guifg=bg
        endif
    else
        highlight DiffAdd cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#1A2B3C guifg=bg
        highlight DiffDelete cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#CE4100 guifg=bg
        highlight DiffChange cterm=NONE ctermbg=17 ctermfg=10 gui=NONE guibg=#A2ECEC guifg=Black
        highlight DiffText cterm=NONE ctermbg=88 ctermfg=10 gui=NONE guibg=#D20300 guifg=bg
    endif

" ignore the white space during the comparison
    set diffopt+=iwhite
    set diffexpr=""

" utf-8 as standard encoding
    set encoding=utf-8
" unix as standard file type
    set ffs=unix,dos,mac

" pop-up menu color
    highlight Pmenu guibg=Green guifg=Black
    highlight PmenuSel guibg=Blue guifg=White
    highlight PmenuSbar ctermbg=Red guibg=Red
    highlight PmenuThumb ctermfg=Yellow guifg=Yellow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" files backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set nobackup
    set nowb
    set noswapfile
    set undolevels=1000
    set updatecount=100


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" be smart when using tabs
     set smarttab
" 1 tab = 4 spaces
    set shiftwidth=4
    set tabstop=4
    "set softtabstop=4
" round indent to nearest multiple of 4
    set shiftround

" linebreak on 80 characters
    set lbr
    "set tw=80

    set ai " auto indent
    set si " smart indent
    set wrap " wrap lines
    "set nowrap " nowrap lines

" horizontal scroll bar if nowrap is set else no horizontal scroll ball
" (comment the set wrap in order to work the below command)
    ":nnoremap <silent><expr> <f2> ':set wrap! go'.'-+'[&wrap].="b\r"
    "set guioptions+=b

" convert tabs to space before writing a file
    set expandtab
    autocmd! bufwritepre * set expandtab | retab! 4

" show the indent guides
    set list
    "set listchars=tab:⁞\ 
    "set listchars=tab:▌\ 
    "set listchars=tab:▦\ 
" ░ -> 2591
" ▒ -> 2592
" ▓ -> 2593
    "set listchars=tab:▒\ 
    set listchars=tab:\|\-


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>
" text selection color
    if &background == "dark"
        autocmd InsertEnter * highlight Visual gui=NONE guibg=#A0A0FF guifg=Blue
    else
        autocmd InsertEnter * highlight Visual gui=NONE guibg=#7F00FF guifg=Yellow
    endif
" toggle mini buffer explorer
    map <leader>mb :TMiniBufExplorer<cr>
" nerdtree
autocmd VimEnter * :NERDTree
autocmd VimEnter * wincmd p

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")) | q | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" moving around tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" treat long lines as break lines
    map j gj
    map k gk
" map undo u and ctrl-r with g- and g+
    "map u g-
    "map <C-r> g+
" map <Space> to / (search) and Ctrl-<Space> to ? (backward search)
    "map <space> ?
    "map <c-space> /
" disable highlight when <leader><cr> is pressed
    map <silent> <leader><cr> :noh<cr>
" smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l
" close the current buffer
    "map <leader>bd :Bclose<cr>
    map <leader>bd :bdelete<cr>
" close all the buffers
    map <leader>ba :1,1000 bd!<cr>

" useful mappings for managing tabs
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove

" open more than 10 tabs using -p option in gvim
    set tabpagemax=50

    set guitablabel=\[%N\]\ %t\ %M
    set guioptions-=m
    set guioptions-=T

" opens a new tab with the current buffer's path
" useful when editing files in the same directory
    map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
"switch CWD to the directory of the open buffer
    map <leader>cd :cd %:p:h<cr>:pwd<cr>

"specify the behavior when switching between buffers
    try
        set switchbuf=useopen,usetab,newtab
        set stal=2
    catch
    endtry
"return to last edit position when opening files
    autocmd BufReadPost *
        \ if line("'\"") >0 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
" remember the info about open buffers on close
    set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" a function which returns the highlight group syntax under the cursor
    function! SyntaxItem()
      return synIDattr(synID(line("."),col("."),1),"name")
    endfunction
" always show the status line
    set laststatus=2
" format the status line
    set statusline =%3*\%n\ %*                             " Buffer Number
    "set statusline +=%5*%{&ff}%*                            " File Format
    set statusline +=%1*%y%*                                " File Type
    set statusline +=%*\ %<%F%*                            " Full Path
    set statusline +=%2*%m\ %*                                " Modified Flag
    "set statusline+=%{SyntaxItem()}                         " syntax highlight group under cursor
    set statusline +=%5*%w\%=\ CWD:\ %r%{getcwd()}%h%*      " Current Working Directory
    set statusline +=%1*\ \%l%*                                " Current Line
    set statusline +=%2*/%*%1*%L\%*                          " Total Lines
    set statusline +=%3*%3v\%*                             " Virtual Column Number
    "set statusline +=%2*0x%04B\ %*                          " Character Under Cursor
"    set statusline +=%4*\ %<%F%*                            " Full Path
    if &background == "dark"
        autocmd InsertEnter * hi statusline gui=NONE guibg=#00FF7F guifg=Black
        autocmd InsertLeave * hi statusline gui=NONE guibg=#FF007F guifg=White
        hi statusline guifg=White      guibg=Grey20
        hi User1 guifg=Black           guibg=Cyan
        hi User2 guifg=Red             guibg=Cyan
        hi User3 guifg=Red             guibg=Yellow
        hi User4 guifg=Blue            guibg=White
        hi User5 guifg=Black           guibg=Grey80
        autocmd InsertEnter * hi User5 guifg=White   guibg=#103F10
        autocmd Insertleave * hi User5 guifg=Black   guibg=#FFBFBF
    else
        autocmd InsertEnter * hi statusline gui=NONE guibg=#008000 guifg=White
        autocmd InsertLeave * hi statusline gui=NONE guibg=#FF3030 guifg=Black
        hi statusline guifg=Black      guibg=Grey80
        hi User1 guifg=Blue            guibg=#00FFFF
        hi User2 guifg=Red             guibg=#00FFFF
        hi User3 guifg=Red             guibg=Yellow
        hi User4 guifg=Yellow          guibg=Black
        hi User5 guifg=Black           guibg=Grey80
        autocmd InsertEnter * hi User5 guifg=#00FF7F guibg=Black
        autocmd Insertleave * hi User5 guifg=#FF007F guibg=Grey10
    endif
   " autocmd InsertEnter * highlight User1 guifg=Yellow guibg=
   " autocmd InsertEnter * highlight User2 guifg=White guibg=
   " autocmd InsertEnter * highlight User3 guifg=Blue guibg=
   " autocmd InsertEnter * highlight User4 guifg=LightGreen guibg=
   " autocmd InsertEnter * highlight User5 guifg=Magenta guibg=
   " autocmd InsertLeave * highlight User1 guifg=Yellow guibg=
   " autocmd InsertLeave * highlight User2 guifg=White guibg=
   " autocmd InsertLeave * highlight User3 guifg=Blue guibg=
   " autocmd InsertLeave * highlight User4 guifg=LightGreen guibg=
   " autocmd InsertLeave * highlight User5 guifg=Magenta guibg=

"    set statusline=\ %n\ %{HasPaste()}%F%m%r%h\ %w\%=\ CWD:\ %r%{getcwd()}%h\ \ %l/%L\;\ %c
"    if &background == "dark"
"        autocmd InsertEnter * highlight statusline gui=NONE guibg=#00FF7F guifg=Black
"        autocmd InsertLeave * highlight statusline gui=NONE guibg=#FF007F guifg=White
"    else
"        autocmd InsertEnter * highlight statusline gui=NONE guibg=#008000 guifg=White
"        autocmd InsertLeave * highlight statusline gui=NONE guibg=#FF3030 guifg=Black
"    endif

    hi p0 guifg=Blue guibg=Violet
    hi p1 guifg=White guibg=Red
    hi p2 guifg=Blue guibg=Green
    hi p3 guifg=White guibg=Blue
    hi p4 guifg=Yellow guibg=Magenta
    hi p5 guifg=Black guibg=LightGreen
    hi p6 guifg=Red guibg=Cyan
    hi p7 guifg=Cyan guibg=DarkRed
    hi p8 guifg=Yellow guibg=DarkGreen
    hi p9 guifg=Red guibg=DarkBlue

    map <leader>p0 :syntax match p0 //<left>
    map <leader>p1 :syntax match p1 //<left>
    map <leader>p2 :syntax match p2 //<left>
    map <leader>p3 :syntax match p3 //<left>
    map <leader>p4 :syntax match p4 //<left>
    map <leader>p5 :syntax match p5 //<left>
    map <leader>p6 :syntax match p6 //<left>
    map <leader>p7 :syntax match p7 //<left>
    map <leader>p8 :syntax match p8 //<left>
    map <leader>p9 :syntax match p9 //<left>

set titlestring=%t\ %m\ (%{expand('%:p:h')})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remap vim 0 to first non-blank character
    "map 0 ^
" remove the trailing white space at the end of each line
    nmap tsr :%s/\s\+$//<ENTER><ESC>
    function! TSR_range () range
        if (a:firstline <= a:lastline)
            execute printf(':%d,%ds/\s\+$//', a:firstline, a:lastline)
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction
" remove the white space at the begin of each line
    "nmap bsr :%le<ENTER><ESC>
    nmap bsr :%s/^\s\+<ENTER><ESC>
    function! BSR_range () range
        if (a:firstline <= a:lastline)
            execute printf(':%d,%ds/^\s\+', a:firstline, a:lastline)
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction
" remove multiple spaces to single space
    nmap msr :%s/  \+/ /g<ENTER><ESC>
    function! MSR_range () range
        if (a:firstline <= a:lastline)
            execute printf(':%d,%ds/  \+/ /g', a:firstline, a:lastline)
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction
" open the path under the cursor in a new tab on the right side of the window
    noremap gl <C-w>gf:tabm<ENTER>
" open the path under the cursor in a vertical split right side window
    noremap gs <C-w>vgf
" open the nerdtree in vertical split window to right
    noremap <leader>T :vs<ENTER>:E<ENTER>
" open the nerdtree in new tab to right
    noremap tt :tabe<ENTER>:E<ENTER>
" select all
    "nmap <m-a> ggVG
" duplicate the selected text
    map <m-d> y<ESC>P

" remove the windows ^M - when the encoding gets messed up
    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when you press gv you vimgrep after the selected text
    vnoremap <silent> gv :call VisualSelection('gv')<CR>
" open vimgrep and put the cursor in the right position
    map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
" vimgrep in the current file
    map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>
" when you press the leader you can search and replace the selected text
    vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pressing ss will togle and untoggle spell checking
    map <leader>ss :setlocal spell!<cr>
" shortcuts using <leader>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=

" keep search matches in the middle of the window
   "nnoremap n nzzzv
   "nnoremap N NzzzV

    if &background == "dark"
        au InsertLeave * hi Search      guifg=Black     guibg=Yellow
        au InsertEnter * hi Search      guifg=Black     guibg=#FF7777
    else
        au InsertLeave * hi Search      guifg=#0000FF guibg=#00FF00
        au InsertEnter * hi Search      guifg=Black   guibg=Cyan
    endif
hi Search       ctermfg=black   ctermbg=darkYellow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helpfull functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" automatically change dir to the dir that the currently working file is
    "if exists("+autochdir")
    "    set autochdir
    "else
    "    autocmd BufEnter * lcd %:p:h
    "endif

    function! CmdLine(str)
        exe "menu Foo.Bar:" . a:str
        emenu Foo.Bar
        unmenu Foo
    endfunction

    function! VisualSelection(direction) range
        let l:saved_reg=@"
        execute "normal!vgvy"
        let l:pattern = escape(@", '\V.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")
        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . '**/*.')
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif
        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

" return true if paste mode is enabled
    function! HasPaste()
        if &paste
            return 'PASTE MODE'
        en
        return ''
    endfunction

" dont close a window, when deleting a buffer
    command! Bclose call <SID>BufcloseCloselt()
    function! <SID>BufcloseCloselt()
        let l:currentBufNum = bufnr("%")
        let l:alternateBufNum = bufnr("#")
        if buflisted(l:alternateBufNum)
            buffer #
        else
            bnext
        endif
        if bufnr("%") == l:currentBufNum
            new
        endif
        if buflisted(l:currentBufNum)
            execute("bdelete! ".l:currentBufNum)
        endif
    endfunction

" tab to complete the word
    function! Tab_Or_Complete()
        if col('.')>1 && strpart( getline('.'), col('.')-2,3 ) =~'^\w'
            return "\<C-N>"
        else
            return "\<Tab>"
        endif
    endfunction
    :inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
" tab completion stuff for command line
    set wildmode=longest,list,full

" press the '-' key to comment a line and '_' key to uncomment it
    filetype on
    augroup vimrc_filetype
        autocmd!
        autocmd FileType c call s:MyCSettings()
        autocmd FileType verilog call s:MyVerilogSettings()
        autocmd FileType sv call s:MyVerilogSettings()
        autocmd FileType vim call s:MyVimSettings()
        autocmd FileType tcl call s:MyTCLSettings()
    augroup end
    " clear all comment markers (one rule for all langauges)
        "map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
        "map _ :s/\(^\s*\)\@<=\/\/\\|\(^\s*\)\@<=--\\|\(^\s*\)\@<=> \\|\(^\s*\)\@<=[#"%!;]//<CR>
    function! s:MyCSettings()
        " insert comments markers
        "map - :s/^/\/\/<CR>
        "map _ :s/\(^\s*\)\@<=\/\///<CR>
        function! C_Comment()
            let @t = getreg('/')
            execute 's/^/\/\/'
            let @/ = getreg('t')
        endfunction
        function! C_Uncomment()
            let @t = getreg('/')
            execute 's/\(^\s*\)\@<=\/\///'
            let @/ = getreg('t')
        endfunction
        map - :call C_Comment()<CR><CR>
        map _ :call C_Uncomment()<CR><CR>
    endfunction
    function! s:MyVerilogSettings()
        " insert comments markers
        "map - :s/^/\/\/<CR>
        "map _ :s/\(^\s*\)\@<=\/\///<CR>
        function! Verilog_Comment()
            let @t = getreg('/')
            execute 's/^/\/\/'
            let @/ = getreg('t')
        endfunction
        function! Verilog_Uncomment()
            let @t = getreg('/')
            execute 's/\(^\s*\)\@<=\/\///'
            let @/ = getreg('t')
        endfunction
        map - :call Verilog_Comment()<CR><CR>
        map _ :call Verilog_Uncomment()<CR><CR>
    endfunction
    function! s:MyVimSettings()
        " insert comments markers
        "map - :s/^/\"/<CR>
        "map _ :s/\(^\s*\)\@<=\"//<CR>
        function! Vim_Comment()
            let @t = getreg('/')
            execute 's/^/\"/'
            let @/ = getreg('t')
        endfunction
        function! Vim_Uncomment()
            let @t = getreg('/')
            execute 's/\(^\s*\)\@<=\"//'
            let @/ = getreg('t')
        endfunction
        map - :call Vim_Comment()<CR><CR>
        map _ :call Vim_Uncomment()<CR><CR>
    endfunction
    function! s:MyTCLSettings()
        " insert comments markers
        "map - :s/^/\#/<CR>
        "map _ :s/\(^\s*\)\@<=\#//<CR>
        function! TCL_Comment()
            let @t = getreg('/')
            execute 's/^/\#/'
            let @/ = getreg('t')
        endfunction
        function! TCL_Uncomment()
            let @t = getreg('/')
            execute 's/\(^\s*\)\@<=\#//'
            let @/ = getreg('t')
        endfunction
        map - :call TCL_Comment()<CR><CR>
        map _ :call TCL_Uncomment()<CR><CR>
    endfunction

" function for removing the Last N Characters in a given range of line usage
" :3, 10call RLNC(5)
    function! RLNC (n) range
        if (a:firstline <= a:lastline)
            execute printf(':%d,%ds/.\{%d}$//', a:firstline, a:lastline, a:n)
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

" function for removing the First N Characters in a given range of line usage
" :3, 10call RFNC(5)
    function! RFNC (n) range
        if (a:firstline <= a:lastline)
            execute printf(':%d,%ds/^.\{%d}//', a:firstline, a:lastline, a:n)
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

" function for Moving the specified Characters in a given range of line to the
" specified Column
" NOTE 1 :- if the specified character and the first character of the line are
"           same then the number of occurance (num_occr) will be one less than
"           the actual
" NOTE 2 :- maximum space difference between the specified characters with in
"           the range of lines should be less than or equal to 80, for more
"           than 80 we need to insert more spaces by increasing the space in
"           the "nmap" of "s"
" :3, 10call MCC(2, ':', 53)
    function! MCC (num_occr, mv_char, col_num) range
        if (a:firstline <= a:lastline)
            nmap s 80i <ESC>
            let line_num = a:firstline
            while line_num <= a:lastline
                execute "normal " . line_num . "G0" . a:num_occr . "f" . a:mv_char . "s" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

    function! MPC (num_occr, mv_pat, col_num) range
        if (a:firstline <= a:lastline)
            set nowrapscan
            set noignorecase
            nmap s 80i <ESC>
            let line_num = a:firstline
"            execute "/" . a:mv_pat
            while line_num <= a:lastline
                silent! execute "normal " . line_num . "G0"
                silent! execute '/\%' . line(".") . 'l' . a:mv_pat
                execute "normal " . a:num_occr . "ns" . a:col_num . "|dw"
"                execute "normal " . line_num . "G0" . a:num_occr . "ns" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
            set wrapscan
            set ignorecase
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

"    function! MPC (num_occr, mv_pat, col_num) range
"        if (a:firstline <= a:lastline)
"            set nowrapscan
"            nmap s 80i <ESC>
"            let line_num = a:firstline
"            while line_num <= a:lastline
"                execute "normal " . line_num . "G0V"
"                execute '/\%V' . a:mv_pat
"                execute "normal " . a:num_occr . "ns" . a:col_num . "|dw"
"                let line_num = line_num + 1
"            endwhile
"            nunmap s
"            set wrapscan
"        else
"            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
"        endif
"    endfunction

" function for Moving the specified Characters in a given range of line to the
" specified Column from end of line
" NOTE 1 :- if the specified character and the last character of the line are
"           same then the number of occurance (num_occr) will be one less than
"           the actual
" NOTE 2 :- maximum space difference between the specified characters with in
"           the range of lines should be less than or equal to 80, for more
"           than 80 we need to insert more spaces by increasing the space in
"           the "nmap" of "s"
" :3, 10call MCCI(2, ':', 53)
    function! MCCI (num_occr, mv_char, col_num) range
        if (a:firstline <= a:lastline)
            nmap s 80i <ESC>
            let line_num = a:firstline
            while line_num <= a:lastline
                execute "normal " . line_num . "G$" . a:num_occr . "F" . a:mv_char . "s" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

    function! MPCI (num_occr, mv_pat, col_num) range
        if (a:firstline <= a:lastline)
            set nowrapscan
            set noignorecase
            nmap s 80i <ESC>
            let line_num = a:firstline
"            execute "/" . a:mv_pat
            while line_num <= a:lastline
                silent! execute "normal " . line_num . "G$"
                silent! execute '/\%' . line(".") . 'l' . a:mv_pat
                execute "normal " . a:num_occr . "Ns" . a:col_num . "|dw"
"                execute "normal " . line_num . "G$" . a:num_occr . "Ns" . a:col_num . "|dw"
                let line_num = line_num + 1
            endwhile
            nunmap s
            set wrapscan
            set ignorecase
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

" function for Moving the specified Column in a given range of line to the
" specified Column
" NOTE 1 :- maximum space difference between the specified column with in
"           the range of lines should be less than or equal to 80, for more
"           than 80 we need to insert more spaces by increasing the space in
"           the "nmap" of "s"
" :3, 10call MC(12,41)
    function! MC (from_col_num, to_col_num) range
        if (a:from_col_num == 0)
            execute printf('ERROR : from_col_num is zero')
        elseif (a:to_col_num == 0)
            execute printf('ERROR : to_col_num is zero')
        elseif (a:from_col_num >= a:to_col_num)
            execute printf('ERROR : from_col_num %d is greater than or equal to to_col_num %d', a:from_col_num, a:to_col_num)
        else
            if (a:firstline <= a:lastline)
                nmap s 80i <ESC>
                let from_col = a:from_col_num - 1
                let line_num = a:firstline
                while line_num <= a:lastline
                    if (from_col == 0)
                        execute "normal " . line_num . "G0" . from_col . "s" . a:to_col_num . "|dw"
                    else
                        execute "normal " . line_num . "G0" . from_col ."ls" . a:to_col_num . "|dw"
                    endif
                    let line_num = line_num + 1
                endwhile
                nunmap s
            else
                execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
            endif
        endif
    endfunction

" function to insert spaces at the end of each line to make all the lines with
" equal number of characters
    function! Make_Equal_Char_Line (num_char) range
        if (a:firstline <= a:lastline)
            let col_num = a:num_char
            let col_num_p = a:num_char + 1
            nmap s A <ESC>
            let line_num = a:firstline
            while line_num <= a:lastline
                execute "normal " . line_num . "G$" . col_num . "s" . col_num_p . "|D"
                let line_num = line_num + 1
            endwhile
            nunmap s
        else
            execute printf('ERROR : Start line %d is higher than End line %d', a:firstline, a:lastline)
        endif
    endfunction

" multiply press 4<F5> to multiply the number under curser with 4
    function! Multiply()
        " save count
        let cnt        = v:count1
        " save register v
        let old_reg    = getreg("v")
        " select the number under the cursor
        call search('\d\([^0-9\.]\|$\)', 'cW')
        normal v
        call search('\(^\|[^0-9\.]\d\)', 'becW')
        " yank it into register v then reselect
        normal "vygv
        " change the selection with the yanked number multiplied by the count
        execute "normal c" . @v * cnt
        " restore register v
        call setreg("v", old_reg)
    endfunction
nnoremap <F5> :<C-u>call Multiply()<CR>

" default syntax for unknown file type
    au BufRead,BufNewFile *.v?v set filetype=verilog
    au BufRead,BufNewFile *.svh set filetype=sv
    au BufRead,BufNewFile *.rpt set filetype=fortran
    au BufRead,BufNewFile *.xdc set filetype=tcl
    au BufRead,BufNewFile *.sdc set filetype=fortran
    au BufRead,BufNewFile *.fdc set filetype=conf
    au BufRead,BufNewFile *.txt set filetype=fortran
    au BufRead,BufNewFile *.log set filetype=fortran
    au BufRead,BufNewFile *.out set filetype=fortran

"   nnoremap n nzv:call BlinkCursorLine()<ESC>
"   nnoremap N Nzv:call BlinkCursorLine()<ESC>
"   "if has('gui_running')
"   "    let g:BlinkColorList = [ '#AF0000', '#9F0000', '#900000' ]
"       let g:BlinkColorList = ['#AF0000', '#900000']
"       let g:bgcolor = 'guibg'
"   "else
"   "    let g:BlinkColorList = [ 'DarkGreen', 'Green', 'PaleGreen' ]
"   "    let g:bgcolor = 'ctermbg'
"   "endif
"   function! BlinkCursorLine()
"       for col_i in g:BlinkColorList
"           execute 'hi CursorLine ' . g:bgcolor . '=' . col_i
"           redraw
"           sleep 5m
"       endfor
"       for col_i in reverse(copy(g:BlinkColorList))
"           execute 'hi CursorLine ' . g:bgcolor . '=' . col_i
"           redraw
"           sleep 5m
"       endfor
"       execute 'hi CursorLine ' . g:bgcolor '=Grey25'
"   endfunction

"function! HighlightRegion(color)
"    let l_start = line("'<")
"    let l_end = line("'>") + 1
"    execute 'syntax region ' . a:color . ' start=/\%' . l_start . 'l/ end=/\%' . l_end . 'l/'
"endfunction
