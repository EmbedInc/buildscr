@echo off
rem
rem   SRC_USERLIBS lnkfile
rem
rem   Add commands to the linker command file LNKFILE to include the current
rem   user's libraries.  These are in the ~/lib_dbg directory.
rem
setlocal
call treename_var ~/lib_dbg libdir
if exist "%libdir%" echo /libpath:%libdir% >>%1
