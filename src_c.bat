@echo off
rem
rem   SRC_C <src dir lnam> <.C file name> [-dbg]
rem
rem   Build a C source file.  The first argument is the leafname of the
rem   source directory.  The second is the generic name of the source
rem   file.  The file will be copied into the approriate SRC directory
rem   and compiled.
rem

call src_get %1 %2.c 3 5 7 9 11 40 41
call src_c_raw %2 %3
