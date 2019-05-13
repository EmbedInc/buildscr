@echo off
rem
rem   SRC_GET_INS_DSPIC <src dir lnam> [<subdir>] <.INS.DSPIC file gnam>
rem
rem   Get a dsPIC assembler include file.  The first argument is the leafname of
rem   the source directory.  The second is the generic name of the source file.
rem   The file will be copied into the approriate SRC directory but otherwise
rem   not altered.
rem
set lnam=%~1
set subd=
set gnam=%~2
if not "%3"=="" (
  set subd=%~2
  set gnam=%~3
  )
echo %gnam%.ins.dspic
call src_get %lnam% %subd% %gnam%.ins.dspic 10 18 30 31
set lnam=
set subd=
set gnam=
