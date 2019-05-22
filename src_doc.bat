@echo off
rem
rem   SRC_DOC gnam
rem
rem   Install the indicated documentation file or directory in the appropriate
rem   place.  GNAM is the generic name of the file.
rem
setlocal
call treename_var "(cog)source/%srcdir%" tnam
cd /d "%tnam%"
if not "%buildname%"=="" cd "%buildname%"

call treename_var "(cog)doc" tnam

if exist "%~1" (
  echo Doc %~1
  copyt -from "%~1" -to "%tnam%/%~1" -nshow
  goto :eof
  )

if exist "%~1.htm" (
  echo "%~1.htm"
  copya -in "%~1.htm" -out "%tnam%/%~1.htm"
  goto :eof
  )

if exist "%~1.txt" (
  echo "%~1.txt"
  copya -in "%~1.txt" -out "%tnam%/%~1.txt" -tabs 3
  goto :eof
  )
