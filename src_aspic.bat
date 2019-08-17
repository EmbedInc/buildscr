@echo off
rem
rem   SRC_ASPIC <src dir lnam> <.ASMPIC file name> [arg ... arg]
rem
rem   Build a PIC assembler source file.  The first argument is the leafname of
rem   the source directory.  The second is the generic name of the source file.
rem   The file will be copied into the approriate SRC directory and assembled.
rem
rem   The optional ARG parameters are passed to ASMPIC at the end of the command
rem   line.
rem
setlocal

echo %2.aspic
call src_get %~1 %~2.aspic 10 18 30 31

if "%~3"=="" (
  set p3=
  ) else (
  set p3="%~3"
  )
if "%~4"=="" (
  set p4=
  ) else (
  set p4="%~4"
  )
if "%~5"=="" (
  set p5=
  ) else (
  set p5="%~5"
  )
if "%~6"=="" (
  set p6=
  ) else (
  set p6="%~6"
  )
if "%~7"=="" (
  set p7=
  ) else (
  set p7="%~7"
  )
if "%~8"=="" (
  set p8=
  ) else (
  set p8="%~8"
  )
if "%~9"=="" (
  set p9=
  ) else (
  set p9="%~9"
  )

asmpic "(cog)src/%~1/%~2.aspic" /c- /l- /o+ %p3% %p4% %p5% %p6% %p7% %p8% %p9%
