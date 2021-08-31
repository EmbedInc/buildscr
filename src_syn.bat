@echo off
rem
rem   SRC_SYN <.syn file name>
rem
rem   Build a SYN file.  On success, this will result in <name>.c and <name>.obj
rem   in the SRC directory.
rem
call src_get "%srcdir%" "%~1.syn"
if exist "%~1.c" del "%~1.c"
if exist "%~1.obj" del "%~1.obj"
sst "%~1.syn"
if not exist "%~1.c" exit /b 3

rem   *** TEMPORARY ***
rem   Rename any references into the SYN library to the SYO library.  The old
rem   SYN library has been renamed to SYO.  The new SYN library is a re-write
rem   with a different interface.  This hack here gets are the the bootstrap
rem   problem of existing code referencing the SYN library before that code
rem   can be rebuilt to reference the SYO library.
rem
copya -in "%~1.c" -out "/temp/%~1.c" -repl " syn_" " syo_"
copya -in "/temp/%~1.c" -out "%~1.c" -repl syn_parse_common syo_parse_common
delt "/temp/%~1.c" -nshow
rem
rem   *** END TEMPORARY ***

call compile_c "%~1"
if not exist "%~1.obj" exit /b 3
