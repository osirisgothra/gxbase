" /usr/share/vim/vim74/colors/gabrieldark.vim: a new colorscheme by gabriel
" Written By: Charles E. Campbell, Jr.'s ftplugin/hicolors.vim
" Date: Sat 17 May 2014 09:56:24 AM EDT

" ---------------------------------------------------------------------
" Standard Initialization:
set bg=dark
hi clear
if exists( "syntax_on")
 syntax reset
endif
let g:colors_name="/usr/share/vim/vim74/colors/gabrieldark"

" ---------------------------------------------------------------------
" Highlighting Commands:
hi SpecialKey     term=bold cterm=bold ctermfg=4 guifg=Cyan
hi NonText        term=bold ctermfg=4 gui=bold guifg=Blue
hi Directory      term=bold cterm=bold ctermfg=9 guifg=Cyan
hi ErrorMsg       term=standout cterm=bold ctermfg=1 ctermbg=1 guifg=White guibg=Red
hi IncSearch      term=reverse cterm=reverse ctermfg=0 ctermbg=3 gui=reverse
hi Search         term=reverse cterm=bold,underline ctermfg=6 ctermbg=4 guifg=Black guibg=Yellow
hi MoreMsg        term=bold cterm=bold,underline ctermfg=8 gui=bold guifg=SeaGreen
hi ModeMsg        term=bold cterm=bold ctermfg=8 ctermbg=4 gui=bold
hi LineNr         term=underline ctermfg=4 guifg=Yellow
hi CursorLineNr   term=bold cterm=bold ctermfg=3 gui=bold guifg=Yellow
hi Question       term=standout cterm=bold ctermfg=2 gui=bold guifg=Green
hi StatusLine     term=bold,reverse cterm=bold,reverse ctermfg=6 ctermbg=7 gui=bold,reverse
hi StatusLineNC   term=reverse cterm=reverse ctermfg=4 ctermbg=10 gui=reverse
hi VertSplit      term=reverse cterm=bold,reverse ctermfg=4 ctermbg=4 gui=reverse
hi Title          term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta
hi Visual         term=reverse cterm=reverse ctermfg=6 ctermbg=4 guibg=DarkGrey
hi VisualNOS      term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg     term=standout cterm=bold ctermfg=6 ctermbg=6 guifg=Red
hi WildMenu       term=standout cterm=bold ctermfg=0 ctermbg=5 guifg=Black guibg=Yellow
hi Folded         term=standout ctermfg=2 ctermbg=0 guifg=Cyan guibg=DarkGrey
hi FoldColumn     term=standout ctermfg=9 ctermbg=8 guifg=Cyan guibg=Grey
hi DiffAdd        term=bold ctermfg=0 ctermbg=4 guibg=DarkBlue
hi DiffChange     term=bold ctermfg=0 ctermbg=2 guibg=DarkMagenta
hi DiffDelete     term=bold ctermfg=0 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
hi DiffText       term=reverse cterm=bold ctermfg=0 ctermbg=2 gui=bold guibg=Red
hi SignColumn     term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=Cyan guibg=Grey
hi Conceal        ctermfg=7 ctermbg=0 guifg=LightGrey guibg=DarkGrey
hi SpellBad       term=reverse ctermbg=1 gui=undercurl guisp=Red
hi SpellCap       term=reverse ctermbg=4 gui=undercurl guisp=Blue
hi SpellRare      term=reverse cterm=bold ctermfg=2 ctermbg=5 gui=undercurl guisp=Magenta
hi SpellLocal     term=underline ctermfg=9 ctermbg=6 gui=undercurl guisp=Cyan
hi Pmenu          cterm=bold ctermfg=3 ctermbg=4 guibg=Magenta
hi PmenuSel       cterm=bold,italic ctermfg=3 ctermbg=4 guibg=DarkGrey
hi PmenuSbar      ctermbg=4 guibg=Grey
hi PmenuThumb     cterm=reverse ctermfg=3 ctermbg=4 guibg=White
hi TabLine        term=underline cterm=bold,underline,reverse ctermfg=6 ctermbg=8 gui=underline guibg=DarkGrey
hi TabLineSel     term=bold cterm=bold,reverse ctermfg=6 gui=bold
hi TabLineFill    term=reverse cterm=reverse gui=reverse
hi CursorColumn   term=reverse ctermbg=0 guibg=Grey40
hi CursorLine     term=underline cterm=underline guibg=Grey40
hi ColorColumn    term=reverse ctermbg=1 guibg=DarkRed
hi Cursor         cterm=reverse ctermfg=4 guifg=bg guibg=fg
hi lCursor        guifg=bg guibg=fg
hi MatchParen     term=reverse ctermbg=8 guibg=DarkCyan
hi Normal         ctermfg=7 ctermbg=0
hi Comment        ctermfg=4 guifg=#80a0ff
hi Constant       term=underline cterm=bold ctermfg=7 guifg=#ffa0a0
hi Special        term=bold cterm=bold ctermfg=6 ctermbg=0 guifg=Orange
hi Identifier     term=underline cterm=bold ctermfg=7 guifg=#40ffff
hi Statement      term=bold cterm=bold ctermfg=7 ctermbg=0 gui=bold guifg=#ffff60
hi PreProc        term=underline cterm=bold ctermfg=4 ctermbg=0 guifg=#ff80ff
hi Type           term=underline cterm=bold ctermfg=6 ctermbg=0 gui=bold guifg=#60ff60
hi Underlined     term=underline cterm=underline ctermfg=6 gui=underline guifg=#80a0ff
hi Ignore         ctermfg=0 guifg=bg
hi Error          term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red
hi Todo           term=standout cterm=bold ctermfg=2 ctermbg=3 guifg=Blue guibg=Yellow
hi Label          ctermfg=5 ctermbg=0
hi Operator       cterm=bold ctermfg=0 ctermbg=0
hi cIf0           ctermfg=7
hi hiBarRed01     ctermfg=1
hi hiBarGreen01   ctermfg=1
hi hiBarBlue01    ctermfg=1
hi hiBarRed02     ctermfg=2
hi hiBarRed03     ctermfg=3
hi hiBarRed04     ctermfg=4
hi hiBarRed05     ctermfg=5
hi hiBarRed06     ctermfg=6
hi hiBarRed07     ctermfg=7
hi hiBarRed08     ctermfg=8
hi hiBarRed09     ctermfg=9
hi hiBarRed10     ctermfg=10
hi hiBarRed11     ctermfg=11
hi hiBarRed12     ctermfg=12
hi hiBarRed13     ctermfg=13
hi hiBarRed14     ctermfg=14
hi hiBarRed15     ctermfg=15
hi hiBarRed16     ctermfg=16
hi hiBarGreen02   ctermfg=2
hi hiBarGreen03   ctermfg=3
hi hiBarGreen04   ctermfg=4
hi hiBarGreen05   ctermfg=5
hi hiBarGreen06   ctermfg=6
hi hiBarGreen07   ctermfg=7
hi hiBarGreen08   ctermfg=8
hi hiBarGreen09   ctermfg=9
hi hiBarGreen10   ctermfg=10
hi hiBarGreen11   ctermfg=11
hi hiBarGreen12   ctermfg=12
hi hiBarGreen13   ctermfg=13
hi hiBarGreen14   ctermfg=14
hi hiBarGreen15   ctermfg=15
hi hiBarGreen16   ctermfg=16
hi hiBarBlue02    ctermfg=2
hi hiBarBlue03    ctermfg=3
hi hiBarBlue04    ctermfg=4
hi hiBarBlue05    ctermfg=5
hi hiBarBlue06    ctermfg=6
hi hiBarBlue07    ctermfg=7
hi hiBarBlue08    ctermfg=8
hi hiBarBlue09    ctermfg=9
hi hiBarBlue10    ctermfg=10
hi hiBarBlue11    ctermfg=11
hi hiBarBlue12    ctermfg=12
hi hiBarBlue13    ctermfg=13
hi hiBarBlue14    ctermfg=14
hi hiBarBlue15    ctermfg=15
hi hiBarBlue16    ctermfg=16
hi sudo           ctermfg=2
hi Scrollbar      ctermfg=2 ctermbg=4
hi Menu           cterm=bold ctermfg=3 ctermbg=4
hi AltUnique      ctermfg=2
hi AltAltUnique   ctermfg=3
hi AltConstant    ctermfg=12
hi AltFunction    ctermfg=6
hi AltType        ctermfg=6
hi Green          ctermfg=2
hi Red            ctermfg=1
hi Tags           ctermfg=3
hi White          ctermfg=14
hi Unique         ctermfg=2
hi User8          cterm=bold ctermfg=10
hi User7          ctermfg=7
hi User5          cterm=underline ctermfg=2
hi User6          ctermfg=6
hi User1          ctermfg=3
hi User2          ctermfg=2
hi User3          ctermfg=3
hi User4          ctermfg=5
hi User9          cterm=bold ctermfg=1
hi CtrlHUnderline term=underline cterm=underline gui=underline
hi CtrlHBold      term=bold cterm=bold gui=bold
hi The            ctermfg=3
