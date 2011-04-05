" tabstop and shiftwidth should always be the same
set tabstop=4
set shiftwidth=4 
set noexpandtab    
"set backup 
"set backupdir=~/.vim/backup

noremap ; :!php5 -l %<CR>
map <C-F1> "vyiw:new<CR>:execute "r!lynx -dump http://www.php.net/".@v."<CR>;:1<CR>

" Do not wrap lines automatically
set nowrap

" Correct indentation after opening a phpdocblock and automatic * on every
" line
set formatoptions=qroct

" Use php syntax check when doing :make
set makeprg=php\ -l\ %
" Use errorformat for parsing PHP error output
set errorformat=%m\ in\ %f\ on\ line\ %l

" }}} Settings

" {{{ Command mappings

" Map ; to run PHP parser check
" noremap ; :!php5 -l %<CR>

" Map ; to "add ; to the end of the line, when missing"
noremap ; :s/\([^\t{};]\)$/\1;/<cr>

noremap <F4> ! open http://php.net/<cword><CR>u
"osascript -e 'tell application "Safai" to open "http://php.net/<cword>" '<CR>

" DEPRECATED in favor of PDV documentation (see below!)
" Map <CTRL>-P to run actual file with PHP CLI
" noremap <C-P> :w!<CR>:!php5 %<CR>

" Map <ctrl>+p to single line mode documentation (in insert and command mode)
inoremap <C-P> :call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
" Map <ctrl>+p to multi line mode documentation (in visual mode)
vnoremap <C-P> :call PhpDocRange()<CR>

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
inoremap <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>


" Enable folding by fold markers
"set foldmethod=marker 
 
" Autoclose folds, when moving out of them
"set foldclose=all

"source ~/.vim/php/phpcode.vim

" {{{ Dictionary completion

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=/Users/kim/.vim/php/functionlist.txt dictionary+=/Users/kim/.vim/php/functionlist.txt
" Use the dictionary completion
set complete-=k complete+=k

" }}} Dictionary completion

" {{{ Autocompletion using the TAB key

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
func! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" }}} Autocompletion using the TAB key

"##############################
" {{{ PhpDocumnetor Include section
source ~/.vim/php-doc.vim
"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-P> :call PhpDocSingle()<CR>
"vnoremap <C-P> :call PhpDocRange()<CR>
" }}} PhpDocumnetor Include section
" {{{ Automatic close char mapping
" More common in PEAR coding standard
inoremap  { {<CR>}<C-O>O
" Maybe this way in other coding standards
" inoremap  { <CR>{<CR>}<C-O>O

" inoremap [ []<LEFT>

" Standard mapping after PEAR coding standard
" inoremap ( ()<LEFT>

" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
inoremap <? <?php<CR>?><C-O>O
inoremap <br <br />
inoremap <td <td></td><LEFT><LEFT><LEFT><LEFT><LEFT>
inoremap <tr <tr><CR><TAB><td></td><CR><BS></tr><UP><RIGHT><RIGHT><RIGHT>
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
