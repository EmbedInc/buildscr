@echo off
rem
rem   SRC_PAS <src dir lnam> <.PAS file name> [-dbg]
rem
rem   Build a Pascal source file.  The first argument is the leafname of the
rem   source directory.  The second is the generic name of the source file.  The
rem   file will be copied into the approriate SRC directory and compiled.
rem
rem   The module will be compiled in debug mode if the "-dbg" command line
rem   option is given, or the environment variable DEBUG_PC exists and is set to
rem   "true".
rem
call src_get %~1 %~2.pas 3 5 7 9 11 40 41
call src_pas_raw %~2 %~3
