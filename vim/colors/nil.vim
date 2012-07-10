" Vim color file
" Converted from Textmate theme Tubnil using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Tubnil"

hi Cursor ctermfg=233 ctermbg=15 cterm=NONE guifg=#131415 guibg=#ffffff gui=NONE
hi Visual ctermfg=NONE ctermbg=53 cterm=NONE guifg=NONE guibg=#390e59 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#272727 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#272727 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#272727 gui=NONE
hi LineNr ctermfg=101 ctermbg=235 cterm=NONE guifg=#767571 guibg=#272727 gui=NONE
hi VertSplit ctermfg=239 ctermbg=239 cterm=NONE guifg=#4d4c4a guibg=#4d4c4a gui=NONE
hi MatchParen ctermfg=44 ctermbg=NONE cterm=underline guifg=#00d2e5 guibg=NONE gui=underline
hi StatusLine ctermfg=188 ctermbg=239 cterm=bold guifg=#dad6cd guibg=#4d4c4a gui=bold
hi StatusLineNC ctermfg=188 ctermbg=239 cterm=NONE guifg=#dad6cd guibg=#4d4c4a gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=53 cterm=NONE guifg=NONE guibg=#390e59 gui=NONE
hi IncSearch ctermfg=233 ctermbg=149 cterm=NONE guifg=#131415 guibg=#a9d158 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Folded ctermfg=95 ctermbg=233 cterm=NONE guifg=#747166 guibg=#131415 gui=NONE

hi Normal ctermfg=188 ctermbg=233 cterm=NONE guifg=#dad6cd guibg=#131415 gui=NONE
hi Boolean ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi Character ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Comment ctermfg=95 ctermbg=NONE cterm=NONE guifg=#747166 guibg=NONE gui=NONE
hi Conditional ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb6a27 guibg=NONE gui=NONE
hi Constant ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi Define ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi DiffAdd ctermfg=188 ctermbg=64 cterm=bold guifg=#dad6cd guibg=#427f09 gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#870404 guibg=NONE gui=NONE
hi DiffChange ctermfg=188 ctermbg=17 cterm=NONE guifg=#dad6cd guibg=#1a2f4e gui=NONE
hi DiffText ctermfg=188 ctermbg=24 cterm=bold guifg=#dad6cd guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=15 ctermbg=160 cterm=NONE guifg=#ffffff guibg=#cc0000 gui=NONE
hi WarningMsg ctermfg=15 ctermbg=160 cterm=NONE guifg=#ffffff guibg=#cc0000 gui=NONE
hi Float ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi Function ctermfg=205 ctermbg=52 cterm=NONE guifg=#f26fbc guibg=#4a0a2f gui=NONE
hi Identifier ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e45b3e guibg=NONE gui=NONE
hi Keyword ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi Label ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi NonText ctermfg=238 ctermbg=234 cterm=NONE guifg=#404040 guibg=#1d1e1e gui=NONE
hi Number ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi Operator ctermfg=66 ctermbg=NONE cterm=NONE guifg=#3d8f9a guibg=NONE gui=NONE
hi PreProc ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi Special ctermfg=188 ctermbg=NONE cterm=NONE guifg=#dad6cd guibg=NONE gui=NONE
hi SpecialKey ctermfg=238 ctermbg=235 cterm=NONE guifg=#404040 guibg=#272727 gui=NONE
hi Statement ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb6a27 guibg=NONE gui=NONE
hi StorageClass ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e45b3e guibg=NONE gui=NONE
hi String ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi Tag ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi Title ctermfg=188 ctermbg=NONE cterm=bold guifg=#dad6cd guibg=NONE gui=bold
hi Todo ctermfg=95 ctermbg=NONE cterm=inverse,bold guifg=#747166 guibg=NONE gui=inverse,bold
hi Type ctermfg=205 ctermbg=52 cterm=NONE guifg=#f26fbc guibg=#4a0a2f gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb6a27 guibg=NONE gui=NONE
hi rubyFunction ctermfg=205 ctermbg=52 cterm=NONE guifg=#f26fbc guibg=#4a0a2f gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi rubyConstant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi rubyInclude ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi rubyRegexp ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi rubyEscape ctermfg=104 ctermbg=NONE cterm=NONE guifg=#797be6 guibg=NONE gui=NONE
hi rubyControl ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb6a27 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=66 ctermbg=NONE cterm=NONE guifg=#3d8f9a guibg=NONE gui=NONE
hi rubyException ctermfg=44 ctermbg=NONE cterm=NONE guifg=#00d2e5 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=95 ctermbg=NONE cterm=NONE guifg=#747166 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi htmlTag ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi htmlEndTag ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi htmlTagName ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi htmlArg ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=167 ctermbg=NONE cterm=NONE guifg=#e45b3e guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi yamlAlias ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3399cc guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=149 ctermbg=NONE cterm=NONE guifg=#a9d158 guibg=NONE gui=NONE
hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName ctermfg=113 ctermbg=NONE cterm=NONE guifg=#7aca3b guibg=NONE gui=NONE
hi cssColor ctermfg=74 ctermbg=NONE cterm=NONE guifg=#34a2d9 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi cssClassName ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffcc33 guibg=NONE gui=NONE
hi cssValueLength ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc66 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=113 ctermbg=NONE cterm=NONE guifg=#99cc33 guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
