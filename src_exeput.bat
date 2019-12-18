@echo off
rem   SRC_EXEPUT <prog> [private]
rem
rem   Install the executable <prog>.exe in the appropriate place.  Other files
rem   that accompany executables, like the documentation, are also installed if
rem   found.
rem
setlocal

set private=
if not "%~2"=="" (
  if not "%~2"=="private" (
    echo Bad argument "%~2".
    exit /b 3
    )
  set private=true
  )
if "%private%"=="" goto :put_global

rem ************************************
rem
rem   Private build.
rem
copyt %1.exe "~/com_dbg/%1.exe"
call treename_var "%sourcedir%/%1_prog.msg" tnam
if exist "%tnam%" copya "%tnam%" "~/env_dbg/%1_prog.msg"
goto :eof

rem ************************************
rem
rem   Global build.
rem
:put_global
copyt %1.exe (cog)com/%1.exe

if exist "z:\embed\com" copyt "%1.exe" "z:\embed\com\%1.exe"
if exist "y:\embed\com" copyt "%1.exe" "y:\embed\com\%1.exe"
del %1.exe
if exist "%homedrive%%homepath%\com_dbg\%1.exe" del "%homedrive%%homepath%\com_dbg\%1.exe"

call treename_var "%sourcedir%/%1.txt" tnam
if not exist "%tnam%" goto :done_doc
copya "%tnam%" "(cog)doc/%1.txt"
if exist "z:\embed\doc" copya "%tnam%" "z:\embed\doc\%1.txt"
if exist "y:\embed\doc" copya "%tnam%" "y:\embed\doc\%1.txt"
:done_doc

call treename_var "%sourcedir%/%1_prog.msg" tnam
if not exist "%tnam%" goto :done_msg
copya "%tnam%" "(cog)env/%1_prog.msg"
if exist "z:\embed\env" copya "%tnam%" "z:\embed\env\%1_prog.msg"
if exist "y:\embed\env" copya "%tnam%" "y:\embed\env\%1_prog.msg"
:done_msg
