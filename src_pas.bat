@echo off
rem
rem   SRC_PAS <src dir lnam> <.PAS file name> [-dbg]
rem
rem   Build a Pascal source file.  The first argument is the
rem   leafname of the source directory.  The second is the generic name
rem   of the source file.  The file will be copied into the approriate
rem   SRC directory and compiled.
rem

call src_get %~1 %~2.pas 3 5 7 9 11 40 41
call src_pas_raw %~2 %~3
