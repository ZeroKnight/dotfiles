" Vim syntax file
" Language:     Quickfix window
" Maintainer:   Andreas Louv <andreas@louv.dk>
" Modified by:  ZeroKnight
" Last Change:  Jul 20, 2024

" Quit when a syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

" Hide start of file path
syn match       Conceal         "^\%(.\{-}/\%([^/]\+|\d\)\@=\)\="
                              \ conceal
                              \ nextgroup=qfFileName

" A bunch of useful C keywords
syn match       qfFileName      "[^/|]*|\@1=" nextgroup=qfSeparator contained
syn match       qfSeparator     "|" nextgroup=qfLineNr contained
syn match       qfLineNr        "[^|]*" contained contains=qfError,qfWarning
syn match       qfError         "error" contained
syn match       qfWarning       "warning" contained

" The default highlighting.
hi def link qfFileName  Directory
hi def link qfLineNr    LineNr
hi def link qfError     Error
hi def link qfWarning   WarningMsg

let b:current_syntax = 'qf'

" vim: ts=8
