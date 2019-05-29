@echo off
rem
rem   SRC_GET_INS_XC16 <src dir lnam> [<subdir>] <.INS.XC16 file gnam>
rem
rem   Get a XC16 "C" include file.  The first argument is the leafname of
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
echo %gnam%.ins.xc16
call src_get %lnam% %subd% %gnam%.ins.xc16 5
set lnam=
set subd=
set gnam=
