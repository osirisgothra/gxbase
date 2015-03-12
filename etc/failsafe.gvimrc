"
" failsafe.gvimrc
" Fallback of .gvimrc
"
" Note: by default, none of this stuff should be enabled
"       it is provided for detail's sake (completeness)
"
" vim: ft=vim:tw=0:ts=4:noet:hls 
"
" see also: failsafe.vimrc
"

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
"if has('gui_gtk2')
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
"else
"  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" changed: inserted gvimrc.local 
"          this was done to allow user to be sure the fallback config is completely untouched

"--- Begin Contents of gvimrc.local ---
" source /etc/gvimrc " no signifigance here so not enabled
"--- End of Contents ---

" original: before the change, the following lines were not commented out (except the first one)
" Source a global configuration file if available
" if filereadable("/etc/vim/gvimrc.local")
"   source /etc/vim/gvimrc.local
" endif
