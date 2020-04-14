@echo off
rem
rem   CALLBAT pathname
rem
rem   Call the indicate BAT file.  PATHNAME can be a arbitrary Embed Inc path
rem   name.  The ".bat" suffix is assumed, and must not be included in PATHNAME.
rem
rem   The target file must be a BAT file.  It will be run from its own
rem   directory.
rem
rem   The environment is not altered.  This script can not be used to run BAT
rem   files intended to alter environment variables.
rem
setlocal
call treename_var "%~1.bat" tnam
if not exist "%tnam%" (
  echo "%tnam%" does not exist.
  exit /b 3
  )
call dirname_var "%tnam%" dnam
cd /d "%dnam%"
call "%tnam%" %2 %3 %4 %5 %6 %7 %8 %9
