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
setlocal

echo %~2.dspic
if "%pictype%"=="" (
  echo   PICTYPE environment variable not defined
  exit /b 3
  )

if exist %~2.S del %~2.S
if exist %~2.s del %~2.s
if exist %~2.as del %~2.as
if exist %~2.lst del %~2.lst
if exist %~2.o del %~2.o
call src_get %1 %~2.dspic 10 18 30 31

prepic %~2.dspic %~2.as
if not exist %~2.as exit /b 3
del %~2.dspic

set opts=-p%pictype%
set opts=%opts% -omf=elf
set opts=%opts% -ahilmns=%2.lst
set opts=%opts% -g
set opts=%opts% -o %2.o %2.as

call extpath_var mplab/asm16.exe tnam
"%tnam%" %opts%
