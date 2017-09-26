" Syntax highlighting, color scheme.
syntax on
set background=dark

" Show ruler line at bottom of each buffer
set ruler
" Show additional info in the command line (very last line on screen) where
" appropriate
set showcmd
" Always display status lines/rulers
set laststatus=2

" Navigation/search

" Show matching brackets/parentheses when navigating around
set showmatch
" Show matching parens in 2/10 of a second
set matchtime=2
" Search incrementally instead of waiting to hit Enter
set incsearch
" Search case-insensitively
set ignorecase
" ... but be smart about it
set smartcase
" Don't highlight search terms by default
set nohls

" Formatting

set autoindent
set smartindent

filetype indent on

set backspace=indent,eol,start
" Automatically indent based on current filetype.
set preserveindent
" Make tabbing/deleting honor 'shiftwidth' as well as 'softtab' and 'tabstop'.
set smarttab
" Use spaces for tabs
set expandtab
" When wrapping/formatting, break at 79 characters.
set textwidth=79
" By default, all indent/tab stuff is 4 spaces, as God intended.
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Default autoformatting options:
" t: automatically hard-wrap based on textwidth
" c: do the same for comments, but autoinsert comment character too
" r: also autoinsert comment character when making new lines after existing
"    comment lines
" o: ditto but for o/O in normal mode
" q: Allow 'gq' to autowrap/autoformat comments as well as normal text
" n: Recognize numbered lists when autoformatting (don't explicitly need this,
"    was probably in a default setup somewhere.)
" 2: Use 2nd line of a paragraph for the overall indentation level when
"    autoformatting.  Good for e.g. bulleted list or other formats where first
"    line in a paragraph my have a different indent than the rest.
set formatoptions=tcroqn2