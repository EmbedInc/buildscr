@echo off
rem
rem   BUILD_PAS <sourcefile>
rem
rem   Compile the Pascal source file and link it with the standard libraries to
rem   create an executable program.  The SOURCEFILE argument is the Pascal
rem   source file name without the .PAS suffix.
rem
rem   Intermediate files will be created (and deleted) in the current directory,
rem   whether the source file is in that directory or not.  This means a Pascal
rem   source file from a remote location can be built, but any temporary files
rem   will be local.
rem
setlocal
call treename_var "%~1.pas" tnam
if not exist "%tnam%" (
  echo No such file: %tnam%
  goto :error
  )
for /f "delims=" %%a in ('leafname "%tnam%" .pas') do set gnam=%%a

rem   TNAM is the complete pathname of the original source file, and
rem   GNAM is the generic leafname.

sst "%tnam%" -out "%gnam%.c" -local_ins
if errorlevel 1 goto :error

call src_c_raw %gnam%
if errorlevel 1 goto :eof
del %gnam%.c

call src_link %gnam% %gnam%
if errorlevel 1 goto :error
del %gnam%.obj
if exist %gnam%.exe goto :eof

rem   An error occurred somewhere along the way.  Delete all the
rem   possible temporary files and exit with error status.
rem
:error
if exist %gnam%.c del %gnam%.c
if exist %gnam%.obj del %gnam%.obj
if exist %gnam%.exe del %gnam%.exe
exit /B 3
