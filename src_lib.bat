@echo off
rem
rem   SRC_LIB <src dir lnam> <library name> [private]
rem
rem   Build the indicated linkable library.  The first argument is the leafname
rem   of the source directory.  The second is the generic name of the library to
rem   build.  The library will be created in the SRC directory, then copied to
rem   the official LIB directory or the user's LIB_DBG directory, depending on
rem   the DBG_SOURCE and DBG_PROMOTE environment variables.
rem
rem   Normally a DLL and its library is also created.  When the environment
rem   variable NO-DLL exists and is set to "true", the DLL and its library are
rem   not created.
rem
rem   The optional third argument "private" indicates this is a private library
rem   that is not to be exported to LIB.  This would be the case, for example,
rem   when the library is really just various modules of a large program.  The
rem   third argument, when present, must be exactly "private".  The library file
rem   will be left in the SRC directory and not moved anywhere.
rem
setlocal
set no-dll=true
call treename_var "(cog)source/%1" source

if exist "%source%\%2_lib.mlist" (
    call src_get %1 %2_lib.mlist
  ) else (
    call src_get %1 %2.mlist
    copya %2.mlist %2_lib.mlist
  )

set private=
if not "%~3"=="" (
  if not "%~3"=="private" (
    echo Bad argument "%~3".
    exit /b 3
    )
  set private=true
  )

rem ************************************
rem
rem   Build the DLL.
rem
if "%no-dll%"=="true" goto :no_dll1
if "%private%"=="true" goto :no_dll1

if exist %2.dll del del %2.dll
if exist %2_dll.lib del %2_dll.lib
if exist %2.lib del %2.lib
if exist %2.exp del %2.exp
if exist %2.lnk del %2.lnk

echo /nologo >>%2.lnk
echo /dll >>%2.lnk
echo /out:%2.dll >>%2.lnk
if not "%3"=="" echo %~3 >>%2.lnk
type "%2_lib.mlist" >>%2.lnk
call src_userlibs %2.lnk
call src_embedlibs %2.lnk
call src_syslibs %2.lnk

setlocal
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%linker%" @%2.lnk
endlocal

if not exist %2.dll exit /b 3
if not exist %2.lib exit /b 3
rename %2.lib %2_dll.lib

:no_dll1

rem ************************************
rem
rem   Build the statically linked library.
rem
if exist %2.lib del %2.lib
if exist %2.exp del %2.exp

setlocal
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%librarian%" /nologo /out:%2.lib @%2_lib.mlist
endlocal

if exist %2.exp del %2.exp
if not exist %2.lib (
  echo Error building %2.lib
  exit /b 3
  )

if "%private%"=="true" goto :eof
if "%dbg_promote%"=="none" goto :eof
if "%dbg_promote%"=="true" goto cp_global
if not defined dbg_source goto cp_global

rem ****************************************************************************
rem
rem   Local build.
rem
copyt %2.lib ~/lib_dbg/%2.lib

if "%no-dll%"=="true" goto :no_dll2
copyt %2.dll ~/com_dbg/%2.dll
copyt %2_dll.lib ~/lib_dbg/%2_dll.lib
:no_dll2

goto :eof

rem ****************************************************************************
rem
rem   global build
rem
:cp_global
copyt %2.lib (cog)lib/%2.lib
if exist %2.ins.pas copya %2.ins.pas (cog)lib/%2.ins.pas
if exist %2.h copya %2.h (cog)lib/%2.h
if exist %23.h copya %23.h (cog)lib/%23.h

if "%no-dll%"=="true" goto :no_dll3
copyt %2.dll (cog)dll/%2.dll
copyt %2_dll.lib (cog)dll/%2_dll.lib
del %2.dll
del %2_dll.lib
:no_dll3
