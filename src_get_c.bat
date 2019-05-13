@echo off
rem
rem   SRC_GET_C <src dir lnam> [<subdir>] <fnam>
rem
rem   Get the indicated file into the build directory.  The file is assumed to
rem   be C source (like H file or main code file), but it is not "built".
rem
set lnam=%~1
set subd=
set gnam=%~2
if not "%3"=="" (
  set subd=%~2
  set gnam=%~3
  )
call src_get %lnam% %subd% %gnam% 3 5 7 9 11 40 41
set lnam=
set subd=
set gnam=
