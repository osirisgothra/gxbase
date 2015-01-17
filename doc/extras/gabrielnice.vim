" gabrielnice.vim: a new colorscheme by gabriel
" Written By: Charles E. Campbell, Jr.'s ftplugin/hicolors.vim
" Date: Wed 23 Apr 2014 03:59:56 PM EDT

" ---------------------------------------------------------------------
" Standard Initialization:
set bg=dark
hi clear
if exists( "syntax_on")
 syntax reset
endif
let g:colors_name="gabrielnice"

" ---------------------------------------------------------------------
" Highlighting Commands:
hi SpecialKey     term=bold cterm=bold ctermfg=4 guifg=Cyan
hi NonText        cterm=bold ctermfg=11 ctermbg=1 gui=bold guifg=Blue
hi Directory      cterm=bold ctermfg=9 guifg=Cyan
hi ErrorMsg       cterm=bold ctermfg=1 guifg=White guibg=Red
hi IncSearch      term=reverse cterm=reverse ctermfg=0 ctermbg=3 gui=reverse
hi Search         term=reverse ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
hi MoreMsg        cterm=bold,underline ctermfg=8 gui=bold guifg=SeaGreen
hi ModeMsg        term=bold cterm=bold ctermfg=4 ctermbg=4 gui=bold
hi LineNr         term=underline cterm=bold ctermfg=6 guifg=Yellow
hi CursorLineNr   term=bold cterm=bold ctermfg=3 gui=bold guifg=Yellow
hi Question       term=standout cterm=bold ctermfg=2 gui=bold guifg=Green
hi StatusLine     cterm=bold ctermbg=2 gui=bold,reverse
hi StatusLineNC   cterm=underline ctermbg=8 gui=reverse
hi VertSplit      term=reverse cterm=bold,reverse ctermfg=4 ctermbg=4 gui=reverse
hi Title          term=bold cterm=bold ctermfg=5 gui=bold guifg=Magenta
hi Visual         term=reverse cterm=reverse ctermfg=6 ctermbg=4 guibg=DarkGrey
hi VisualNOS      term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg     term=standout cterm=bold ctermfg=6 ctermbg=6 guifg=Red
hi WildMenu       term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
hi Folded         ctermfg=2 guifg=Cyan guibg=DarkGrey
hi FoldColumn     ctermfg=9 ctermbg=8 guifg=Cyan guibg=Grey
hi DiffAdd        term=bold ctermfg=0 ctermbg=4 guibg=DarkBlue
hi DiffChange     term=bold ctermfg=0 ctermbg=2 guibg=DarkMagenta
hi DiffDelete     term=bold ctermfg=0 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
hi DiffText       term=reverse ctermfg=0 ctermbg=2 gui=bold guibg=Red
hi SignColumn     term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=Cyan guibg=Grey
hi Conceal        ctermfg=7 ctermbg=0 guifg=LightGrey guibg=DarkGrey
hi SpellBad       term=reverse ctermbg=1 gui=undercurl guisp=Red
hi SpellCap       term=reverse ctermbg=4 gui=undercurl guisp=Blue
hi SpellRare      term=reverse ctermbg=5 gui=undercurl guisp=Magenta
hi SpellLocal     ctermfg=8 ctermbg=6 gui=undercurl guisp=Cyan
hi Pmenu          ctermfg=0 ctermbg=5 guibg=Magenta
hi PmenuSel       cterm=bold ctermfg=0 ctermbg=0 guibg=DarkGrey
hi PmenuSbar      ctermfg=4 ctermbg=7 guibg=Grey
hi PmenuThumb     ctermfg=5 ctermbg=7 guibg=White
hi TabLine        term=underline cterm=bold,underline ctermfg=7 ctermbg=0 gui=underline guibg=DarkGrey
hi TabLineSel     term=bold cterm=bold gui=bold
hi TabLineFill    term=reverse cterm=reverse gui=reverse
hi CursorColumn   term=reverse ctermbg=0 guibg=Grey40
hi CursorLine     term=underline cterm=underline guibg=Grey40
hi ColorColumn    term=reverse ctermbg=1 guibg=DarkRed
hi Cursor         ctermfg=0 ctermbg=7 guifg=bg guibg=fg
hi lCursor        guifg=bg guibg=fg
hi MatchParen     ctermbg=8 guibg=DarkCyan
hi Normal         ctermfg=7 ctermbg=0
hi Comment        term=bold ctermfg=6 ctermbg=0 guifg=#80a0ff
hi Constant       term=underline cterm=bold ctermfg=7 guifg=#ffa0a0
hi Special        term=bold cterm=bold ctermfg=6 ctermbg=0 guifg=Orange
hi Identifier     term=underline cterm=bold ctermfg=7 guifg=#40ffff
hi Statement      term=bold cterm=bold ctermfg=7 ctermbg=0 gui=bold guifg=#ffff60
hi PreProc        term=underline cterm=bold ctermfg=4 ctermbg=0 guifg=#ff80ff
hi Type           term=underline cterm=bold ctermfg=6 ctermbg=0 gui=bold guifg=#60ff60
hi Underlined     term=underline cterm=underline ctermfg=6 gui=underline guifg=#80a0ff
hi Ignore         guifg=bg
hi Error          cterm=bold ctermfg=7 ctermbg=1 guifg=White guibg=Red
hi Todo           term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow
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


hi bashAwkBlockSingle     ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashBlock              ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCase               ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCaseError          ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCaseEsac           ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCaseEsacSync       ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashColon              ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCommandOpts        ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashCommandSub         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                           
hi bashComment            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                         
hi bashConditional        ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold                         
hi bashIfError            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDTestError         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDeref              ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDerefOperator      ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDo                 ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDoError            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDoSync             ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDotStrings         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashDoubleQuote        ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashEcho               ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashEmbeddedEcho       ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashEsacError          ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashFor                ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashForSync            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashFunction           ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashFunctionName       ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashHereDoc            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashIdentifier         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashIf                 ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashIfError            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashIfSync             ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashInError            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashNone               ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashOperator           ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashParenError         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashRedir              ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashRepeat             ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashShellVariables     ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashSinglequote        ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashSource             ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashSpecial            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashSpecialShellVar    ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold  
hi bashSpecialVar         ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold 
hi bashSpecialVars        ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashStatement          ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashString             ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashSubSh              ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashTestError          ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashTestOpr            ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashTodo               ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashVariables          ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold
hi bashWrapLineOperator   ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold

hi bashSpecialShellVariables ctermbg=black  ctermfg=white   guibg=#000000  guifg=#808080  cterm=bold gui=bold

