@echo off
rem
rem   SRC_C_RAW <source file name> [-dbg]
rem
rem   Compile C language source file to produce an object file.  The source
rem   file name argument must not contain the .C suffix.
rem
rem   The -dbg option causes the source file to be compiled for debugging.
rem   Otherwise, the source file is compiled with full optimization.
rem
setlocal
if "%2"=="-dbg" goto dbg

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
