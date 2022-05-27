@echo off
rem
rem   SRC_LIB2 lib [mlist]
rem
rem   Low level script to build a library in-place.  All files are assumed to be
rem   in the current directory.
rem
rem   LIB is the name of the library to create, without the ".lib" suffix.
rem
rem   MLIST is the name of the .MLIST file without the ".mlist" suffix.  This
rem   file contains the list of object files to add to the library.  The default
rem   is <lib>_lib.
rem
if exist %~1.lib del %~1.lib
if exist %~1.exp del %~1.exp

setlocal
set mlist=%~1_lib
if not "%~2"=="" set mlist=%~2
call extpath_var msvc/set_vars.bat tnam
call "%tnam%"
"%librarian%" /nologo /out:%~1.lib @%mlist%.mlist
endlocal

if exist %~1.exp del %~1.exp
if not exist %~1.lib (
  echo Error building %~1.lib
  exit /b 3
  )
