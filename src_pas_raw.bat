@echo off
rem
rem   SRC_PAS_RAW <source file name> [-dbg]
rem
rem   Compile the Pascal language source file to produce an object file.  The
rem   source file name argument must not contain the .PAS suffix.
rem
rem   The module will be compiled in debug mode if the "-dbg" command line
rem   option is given, or the environment variable DEBUG_VS exists and is set to
rem   "true".
rem
setlocal
if "%2"=="-dbg" set DEBUG_VS=true
if exist %~1.obj del %~1.obj
if exist %~1.c del %~1.c

set dbglev=0
if "%DEBUG_VS%"=="true" set dbglev=1
set arg2=
if not "%2"=="-dbg" set arg2=%2

sst %~1.pas -out %~1 -debug %dbglev% %arg2% %3 %4 %5 %6 %7 %8 %9
if errorlevel 1 exit /b 3

call src_c_raw %~1
if errorlevel 1 exit /b 3
if not exist %~1.obj exit /b 3
if not "%DEBUG_VS%"=="true" del %~1.c
