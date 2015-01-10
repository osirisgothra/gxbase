"===============================================================================
"
"          File:  gxbaserc-syntax.vim
" 
"   Description:  Syntax for gxbase config files (*rc) in gxbase directories
" 
"   VIM Version:  7.0+
"        Author:  Gabriel Thomas Sharp (gts), osirisgothra@hotmail.com
"  Organization:  Paradisim Enterprises, LLC - http://paradisim.twilightparadox.com
"       Version:  1.0
"       Created:  11/11/2014 01:34
"      Revision:  ---
"       License:  Copyright (c) 2014, Gabriel Thomas Sharp
"===============================================================================

" vim: noet:ft=vim:tw=999:sw=2:ts=2:fcl=all:fdo=hor:fdm=marker:fmr=<@#,#@>:fen:nowrap:hls:vbs=0:ic


" Vim syntax file
" Language:	.desktop, .directory files
"		according to freedesktop.org specification 0.9.4
" http://pdx.freedesktop.org/Standards/desktop-entry-spec/desktop-entry-spec-0.9.4.html
" Maintainer:	Mikolaj Machowski ( mikmach AT wp DOT pl )
" Last Change:	2004 May 16
" Version Info: desktop.vim 0.9.4-1.2

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
    finish
endif

" This syntax file can be used to all *nix configuration files similar to dos
" ini format (eg. .xawtv, .radio, kde rc files) - this is default mode. But
" you can also enforce strict following of freedesktop.org standard for
" .desktop and .directory files . Set (eg. in vimrc)
" let enforce_freedesktop_standard = 1
" and nonstandard extensions not following X- notation will not be highlighted.
if exists("enforce_freedesktop_standard")
	let b:enforce_freedesktop_standard = 1
else
	let b:enforce_freedesktop_standard = 0
endif

" case on
syn case match

" General
syn match  dtNotStLabel	"^.\{-}=\@=" @s;@



hi	def	link	dtGroup		Special
hi	def	link	dtComment		Comment
hi	def	link	dtDelim		String
hi	def	link	dtLocaleKey		Type
hi	def	link	dtLocaleName	Identifier
hi	def	link	dtXLocale		Identifier
hi	def	link	dtALocale		Identifier
hi	def	link	dtNumericKey	Type
hi	def	link	dtBooleanKey	Type
hi	def	link	dtBooleanValue	Constant
hi	def	link	dtStringKey		Type
hi	def	link	dtExecKey		Type
hi	def	link	dtExecParam		Special
hi	def	link	dtTypeKey		Type
hi	def	link	dtTypeValue		Constant
hi	def	link	dtNotStLabel	Type
hi	def	link	dtXAddKey		Type



let b:current_syntax = "gxbaserc"

" vim:ts=8


