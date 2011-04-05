" {{{ Automatic close char mapping
" More common in PEAR coding standard
inoremap  { {<CR>}<C-O>O
" Maybe this way in other coding standards
" inoremap  { <CR>{<CR>}<C-O>O

inoremap [ []<LEFT>

" Standard mapping after PEAR coding standard
inoremap ( ()<LEFT>

noremap " ""<LEFT>
inoremap ' ''<LEFT>
" }}}

"##############################
" {{{   PHP CONSTRUCTS 
" Function
map! =fun function (<Esc>A {<Esc><Up>f(i

" foreach loop
map! =fe foreach($ as $<Esc>A {<Up><ESC>f$
" for loop
map! =for for($i=0; ; i++<Esc>A {<Up><ESC>10l
"map! =for for($i=0; ; i++)<Right>{<CR>}<Up><ESC>9l

" if statement
map! =if if (<Esc>A {<Esc>ddA else {<Esc>dd<Up><Up>4li
" }}}  PHP Constructs  
"##############################
