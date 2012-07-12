" Vim color file
" Converted from Textmate theme Close to the Sea using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Close to the Sea"

hi Cursor ctermfg=16 ctermbg=15 cterm=NONE guifg=#172024 guibg=#ffffff gui=NONE
hi Visual ctermfg=NONE ctermbg=145 cterm=NONE guifg=NONE guibg=#b5a9ad gui=NONE
hi CursorLine ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#2e3639 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#2e3639 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#2e3639 gui=NONE
hi LineNr ctermfg=245 ctermbg=23 cterm=NONE guifg=#8b908f guibg=#2e3639 gui=NONE
hi VertSplit ctermfg=59 ctermbg=59 cterm=NONE guifg=#5a6162 guibg=#5a6162 gui=NONE
hi MatchParen ctermfg=66 ctermbg=NONE cterm=underline guifg=#5f919a guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=59 cterm=bold guifg=#fffffa guibg=#5a6162 gui=bold
hi StatusLineNC ctermfg=231 ctermbg=59 cterm=NONE guifg=#fffffa guibg=#5a6162 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=145 cterm=NONE guifg=NONE guibg=#b5a9ad gui=NONE
hi IncSearch ctermfg=16 ctermbg=68 cterm=NONE guifg=#172024 guibg=#3a81c8 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi Folded ctermfg=110 ctermbg=16 cterm=NONE guifg=#78b2c7 guibg=#172024 gui=NONE

hi Normal ctermfg=231 ctermbg=16 cterm=NONE guifg=#fffffa guibg=#172024 gui=NONE
hi Boolean ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Character ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi Comment ctermfg=110 ctermbg=NONE cterm=NONE guifg=#78b2c7 guibg=NONE gui=italic
hi Conditional ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#fffffa guibg=#43820c gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#880607 guibg=NONE gui=NONE
hi DiffChange ctermfg=231 ctermbg=23 cterm=NONE guifg=#fffffa guibg=#1c3556 gui=NONE
hi DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#fffffa guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=124 ctermbg=NONE cterm=NONE guifg=#b8252a guibg=NONE gui=NONE
hi Function ctermfg=166 ctermbg=NONE cterm=NONE guifg=#ea511b guibg=NONE gui=NONE
hi Identifier ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fffffa guibg=NONE gui=NONE
hi Keyword ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi Label ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi NonText ctermfg=231 ctermbg=16 cterm=NONE guifg=#fafaf5 guibg=#232b2f gui=NONE
hi Number ctermfg=124 ctermbg=NONE cterm=NONE guifg=#b8252a guibg=NONE gui=NONE
hi Operator ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi PreProc ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi Special ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fffffa guibg=NONE gui=NONE
hi SpecialKey ctermfg=231 ctermbg=23 cterm=NONE guifg=#fafaf5 guibg=#2e3639 gui=NONE
hi Statement ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi StorageClass ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fffffa guibg=NONE gui=NONE
hi String ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi Tag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#fffffa guibg=NONE gui=bold
hi Todo ctermfg=110 ctermbg=NONE cterm=inverse,bold guifg=#78b2c7 guibg=NONE gui=inverse,bold,italic
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi rubyFunction ctermfg=166 ctermbg=NONE cterm=NONE guifg=#ea511b guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi rubyConstant ctermfg=71 ctermbg=NONE cterm=NONE guifg=#54ba42 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=159 ctermbg=NONE cterm=NONE guifg=#c0effe guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=181 ctermbg=NONE cterm=NONE guifg=#d0bfaf guibg=NONE gui=NONE
hi rubyInclude ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi rubyGlobalVariable ctermfg=181 ctermbg=NONE cterm=NONE guifg=#d0bfaf guibg=NONE gui=NONE
hi rubyRegexp ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi rubyEscape ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi rubyControl ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi rubyException ctermfg=66 ctermbg=NONE cterm=bold guifg=#5f919a guibg=NONE gui=bold
hi rubyPseudoVariable ctermfg=181 ctermbg=NONE cterm=NONE guifg=#d0bfaf guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=71 ctermbg=NONE cterm=NONE guifg=#54ba42 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi erubyComment ctermfg=110 ctermbg=NONE cterm=NONE guifg=#78b2c7 guibg=NONE gui=italic
hi erubyRailsMethod ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=231 ctermbg=NONE cterm=NONE guifg=#fffffa guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor ctermfg=181 ctermbg=NONE cterm=NONE guifg=#d0bfaf guibg=NONE gui=NONE
hi yamlAlias ctermfg=181 ctermbg=NONE cterm=NONE guifg=#d0bfaf guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=68 ctermbg=NONE cterm=NONE guifg=#3a81c8 guibg=NONE gui=NONE
hi cssURL ctermfg=159 ctermbg=NONE cterm=NONE guifg=#c0effe guibg=NONE gui=NONE
hi cssFunctionName ctermfg=185 ctermbg=NONE cterm=NONE guifg=#e1da69 guibg=NONE gui=NONE
hi cssColor ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aed4dc guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssClassName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssValueLength ctermfg=124 ctermbg=NONE cterm=NONE guifg=#b8252a guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005c guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
