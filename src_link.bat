@echo off
rem
rem   SRC_LINK <program name> <top .obj file name> [/debug] [other module and libs]
rem
rem   Link the top object file with the standard libraries and any additional
rem   libraries and modules listed on the command line.  The result will be
rem   the executable program named in the first argument.  Note that first two
rem   arguments must NOT end in the implied .EXE and .OBJ suffixes.
rem
setlocal
echo Linking executable %1

if exist %1.exe del %1.exe
if exist %1.lnk del %1.lnk
if exist %1.lib del %1.lib
if exist %1.exp del %1.exp
if exist %1.ilk del %1.ilk
if exist %1.pdb del %1.pdb

echo /nologo >>%1.lnk
echo /out:%1.exe >>%1.lnk
echo /incremental:no >>%1.lnk
echo /subsystem:console,5.1 >>%1.lnk
echo %2.obj >>%1.lnk
if not "%~3"=="" echo %3 >>%1.lnk
if not "%~4"=="" echo %4 >>%1.lnk
if not "%~5"=="" echo %5 >>%1.lnk
if not "%~6"=="" echo %6 >>%1.lnk
if not "%~7"=="" echo %7 >>%1.lnk
if not "%~8"=="" echo %8 >>%1.lnk
if not "%~9"=="" echo %9 >>%1.lnk
call src_userlibs %1.lnk
call src_embedlibs %1.lnk
call src_syslibs %1.lnk

setlocal
call extpath_var msvc/set_vars.bat tnam
call %tnam%
"%linker%" @%1.lnk
endlocal

if exist %1.lib del %1.lib
if exist %1.ilk del %1.ilk
if exist %1.exp del %1.exp

if "%~3"=="/debug" goto dbg
if exist %1.pdb del %1.pdb
if errorlevel 1 goto err
del %1.lnk
:err
:dbg
