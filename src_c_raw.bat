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
call extpath_var msvc/version.bat tnam
call "%tnam%"
if "%2"=="-dbg" goto dbg

rem   Production compile.
rem
set opts=/c /nologo /Gz /Ox
if %VisualStudioVersion%==6 (
  set opts=%opts% /G6 /MT
  )
if %VisualStudioVersion%==2014 (
  set opts=%opts% /GS-
  )
if %VisualStudioVersion%==2017 (
  set opts=%opts% /GS-
  )
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%compiler%" "%~1.c" %opts%
goto :eof

rem   Debug compile.
rem
:dbg
set opts=/c /nologo /Gz /Od
if %VisualStudioVersion%==6 (
  set opts=%opts% /G6 /Zi /MT
  )
if %VisualStudioVersion%==2014 (
  set opts=%opts% /RTCcsu /Z7
  )
if %VisualStudioVersion%==2017 (
  set opts=%opts% /RTCcsu /Z7
  )
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%compiler%" "%~1.c" %opts%
