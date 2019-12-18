@echo off
rem
rem   SRC_PROG <src dir lnam> <.pas top module name> [<mod 1> ... <mod N>] [-dbg]
rem
rem   Build an excutable program from its source module(s).  This
rem   script is only suitable when the build procedure is simple.
rem   Specifically, the following restrictions apply:
rem
rem     1 - The top source module and the executable file have the same
rem         generic name.
rem
rem     2 - All source modules are in Pascal and have a suffix of .pas
rem
rem     3 - There are no more than 7 additional source modules.
rem
rem   The first command line argument is the generic name of the source code
rem   directory that all source files come from.  The second argument is
rem   the generic name of the top source module and the executable.  The
rem   remaining arguments, if any, are the generic names of additional
rem   source modules.  These will be compiled and explicitly linked (no
rem   library will be created) into the executable.
rem
setlocal

if exist %2.exe del %2.exe
set dbg=

call src_go %1

if "%3"=="" (
  set arg3=
  goto done3
  )
if "%3"=="-dbg" (
  set arg3=
  set dbg=-dbg
  goto done3
  )
set arg3=%3
:done3
if "%4"=="" (
  set arg4=
  goto done4
  )
if "%4"=="-dbg" (
  set arg4=
  set dbg=-dbg
  goto done4
  )
set arg4=%4
:done4
if "%5"=="" (
  set arg5=
  goto done5
  )
if "%5"=="-dbg" (
  set arg5=
  set dbg=-dbg
  goto done5
  )
set arg5=%5
:done5
if "%6"=="" (
  set arg6=
  goto done6
  )
if "%6"=="-dbg" (
  set arg6=
  set dbg=-dbg
  goto done6
  )
set arg6=%6
:done6
if "%7"=="" (
  set arg7=
  goto done7
  )
if "%7"=="-dbg" (
  set arg7=
  set dbg=-dbg
  goto done7
  )
set arg7=%7
:done7
if "%8"=="" (
  set arg8=
  goto done8
  )
if "%8"=="-dbg" (
  set arg8=
  set dbg=-dbg
  goto done8
  )
set arg8=%8
:done8
if "%9"=="" (
  set arg9=
  goto done9
  )
if "%9"=="-dbg" (
  set arg9=
  set dbg=-dbg
  goto done9
  )
set arg9=%9
:done9

call src_pas %1 %2 %dbg%
if not exist "%2.obj" goto :eof

if not "%arg3%"=="" (
  call src_pas "%~1" %arg3% %dbg%
  if not exist "%3.obj" goto :eof
  )
if not "%arg4%"=="" (
  call src_pas "%~1" %arg4% %dbg%
  if not exist "%4.obj" goto :eof
  )
if not "%arg5%"=="" (
  call src_pas "%~1" %arg5% %dbg%
  if not exist "%5.obj" goto :eof
  )
if not "%arg6%"=="" (
  call src_pas "%~1" %arg6% %dbg%
  if not exist "%6.obj" goto :eof
  )
if not "%arg7%"=="" (
  call src_pas "%~1" %arg7% %dbg%
  if not exist "%7.obj" goto :eof
  )
if not "%arg8%"=="" (
  call src_pas "%~1" %arg8% %dbg%
  if not exist "%8.obj" goto :eof
  )
if not "%arg9%"=="" (
  call src_pas "%~1" %arg9% %dbg%
  if not exist "%9.obj" goto :eof
  )
set debug=
if "%dbg%"=="-dbg" set debug=/debug
call src_link %2 %2 %debug% %arg3% %arg4% %arg5% %arg6% %arg7% %arg8% %arg9%
set debug=
if not exist %2.exe goto :eof

set private=
if "%dbg%"=="-dbg" set private=private
call src_exeput %2 %private%
