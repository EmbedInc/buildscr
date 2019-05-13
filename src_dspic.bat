@echo off
rem
rem   SRC_DSPIC <src dir lnam> <.DSPIC file name>
rem
rem   Build a dsPIC assembler source file.  The first argument is the
rem   leafname of the source directory.  The second is the generic name
rem   of the source file.  The file will be copied into the approriate
rem   SRC directory and assembled.  A ".o" object output file will
rem   be produced if no errors are found.
rem
rem   The assembler constant DBG_LEVEL is always created.  It is set to
rem   0 for a production build (no DBG_SOURCE environment variable, or
rem   DBG_PROMOTE environment variable set to "true").  The default for
rem   a debug build is 5, although this will be overridden with the
rem   DBG_LEVEL environment variable value if present.
rem
rem   The DSPICDIR environment variable must be set to the dsPIC tools
rem   installation directory.  This directory contains the BIN subdirectory
rem   where the executables are, the SUPPORT > INC subdirectory where
rem   the include files are, etc.
rem

echo %~2.dspic
if "%pictype%"=="" (
  echo   PICTYPE environment variable not defined
  exit /b 3
  )
set dbg_parm=--defsym debug=5
if "%dbg_promote%"=="true" set dbg_parm=--defsym debug=0
if not "%dbg_level%"=="" set dbg_parm=--defsym debug=%dbg_level%
if "%dbg_source%"=="" set dbg_parm=--defsym debug=0

call src_get %1 %~2.dspic 10 18 30 31
if exist %~2.S del %~2.S
if exist %~2.s del %~2.s
if exist %~2.as del %~2.as
if exist %~2.lst del %~2.lst
if exist %~2.o del %~2.o

prepic %~2.dspic %~2.as
if not exist %~2.as exit /b 3
del %~2.dspic

"%dspicdir%\bin\xc16-as" -p%pictype% -omf=elf -ahilmns=%2.lst -I "%embedinc%\src\dspic" -I "%dspicdir%\support\inc" -g %dbg_parm% -o %2.o %2.as
