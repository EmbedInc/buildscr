@echo off
rem
rem   SRC_C_RAW <source file name> [-dbg]
rem
rem   Compile C language source file to produce an object file.  The source file
rem   name argument must not contain the .C suffix.
rem
rem   The module will be compiled in debug mode if the "-dbg" command line
rem   option is given, or the environment variable DEBUG_VS exists and is set to
rem   "true".
rem
setlocal
if "%2"=="-dbg" set DEBUG_VS=true
if "%DEBUG_VS%"=="true" goto dbg

rem   Production compile.
rem
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%compiler%" "%~1.c" /c /nologo /Gz /Ox /GS-
goto :eof

rem   Debug compile.
rem
:dbg
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%compiler%" "%~1.c" /c /nologo /Gz /Od /RTCcsu /Z7
