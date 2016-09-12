set t_Co=256
set background=dark
colorscheme solarized
" colorscheme peaksea
set background=dark
set number
map <leader>nn :NERDTreeTabsToggle<cr>
inoremap $3 {}<esc>i<CR><esc><<i<CR><esc>ki<TAB><TAB>
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2
autocmd Filetype eco setlocal ts=2 sts=2 sw=2

nnoremap <leader>cx  :ccl<CR>

fu! SaveSess()
  execute 'NERDTreeClose'
  execute 'mksession! ~/.session.vim'
endfunction

fu! RestoreSess()
    if argc() == 0
      if filereadable('~/.session.vim')
        execute 'so ~/.session.vim'
        if bufexists(1)
          for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
              exec 'sbuffer ' . l
            endif
          endfor
        endif
      endif
    endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

set sessionoptions-=options  " Don't save options

let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'
let g:easytags_auto_highlight = 0
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
let g:notes_suffix = '.txt'
let g:nerdtree_tabs_open_on_gui_startup=0
" Use OSX clipboard
set clipboard=unnamed

" Convert current markdown file to html and open in Safari.
" noremap <leader>mh :w<cr><esc>:Pandoc<cr><esc>:!open -a "Google Chrome" %:p:t:r.html<cr><cr>
noremap <leader>mh :w<cr><esc>:Pandoc<cr><esc>:!prince %:p:t:r.html %:p:t:r.pdf<cr><cr>:!open %:p:t:r.pdf<cr>
au BufRead,BufNewFile *.md		setfiletype markdown
nnoremap <leader>md i<link href="/Users/brandonduff/dev/markdown.css" rel="stylesheet"></link><cr><esc>
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
nnoremap <C-f> :FZF<cr>

" Vim's new regex engine sucks. Use old one.
set regexpengine=1

set splitbelow
set splitright
map <leader>q :q<cr>
map <leader>t :5sp term://bash<cr>

" Rails mappings
map <leader>rt :Eunittest<cr>
map <leader>rm :Emodel<cr>
map <leader>rc :Econtroller<cr>
map <leader>rr :Rake<cr>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

let g:ragtag_global_maps = 1

" Competitive Programming
function! LoadJavaTemplate()
    read ~/dev/templates/mainTemplate.java
    normal ggddG2wcw
    call append(2, "public class " . expand('%:t:r') . " {")
endfunction
command! Jt call LoadJavaTemplate()
map <leader>br oBufferedReader in = new BufferedReader(new InputStreamReader(System.in));<esc>

command! Rqt read ~/dev/templates/rqtemplate.md

"wRemove trailing whitespace
nnoremap <leader>rw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
tnoremap <Esc> <C-\><C-n>

"Load AutoCorrect on markdown and txt
autocmd filetype pandoc call AutoCorrect()
" Go back to last misspelled word and pick first suggestion.
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u
" Set background to light.
noremap <leader>bl :set background=light<CR>
" Set background to dark.
noremap <leader>bd :set background=dark<CR>

" open currently open file in NERDtree
nnoremap ,f :NERDTreeFind<CR>

" Ruby Refactoring Mappings
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

" copy current file path into unnamed register
nmap cp :let @+ = expand("%:p")<cr>

" Revert hunk under cursor
nnoremap <leader>r GitGutterRevertHunk

nnoremap <leader>g :Grepper -tool git -noswitch<cr>
