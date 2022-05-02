@echo off
rem
rem   SRC_SYO <.syo file name>
rem
rem   Build a SYO file.  On success, this will result in <name>.c and <name>.obj
rem   in the SRC directory.
rem
call src_get "%srcdir%" "%~1.syo"
if exist "%~1.c" del "%~1.c"
if exist "%~1.obj" del "%~1.obj"
sst "%~1.syo"
if not exist "%~1.c" exit /b 3
call compile_c "%~1"
if not exist "%~1.obj" exit /b 3
