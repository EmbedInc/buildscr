@echo off
rem
rem   RUN_PAS <sourcefile> [arg1 ... arg8]
rem
rem   Compile the Pascal source file, link it with the standard libraries
rem   to create an executable program, run the program, then delete the
rem   executable file.  This essentially "runs" a Pascal source file, and
rem   leaves no intermediate files.  The SOURCEFILE argument is the
rem   Pascal source file name without the .PAS suffix.
rem
rem   Intermediate files will be created (and deleted) in the current
rem   directory, whether the source file is in that directory or not.
rem   This means a Pascal source file from a remote location can be run,
rem   but any temporary files will be local.
rem
rem   The optional arguments ARG1 - ARG8 are passed to the program when
rem   it is run.
rem
setlocal
call treename_var %1.pas tnam
if not exist %tnam% (
  echo No such file: %tnam%
  goto error
  )
for /f "delims=" %%a in ('leafname "%tnam%" .pas') do set gnam=%%a

rem   TNAM is the complete pathname of the original source file, and
rem   GNAM is the generic leafname.

sst %tnam% -out %gnam%.c -local_ins
if errorlevel 1 goto error

call compile_c %gnam%
if errorlevel 1 goto :eof
del %gnam%.c

call src_link %gnam% %gnam%
if errorlevel 1 goto error
del %gnam%.obj
if not exist %gnam%.exe goto :eof

copya -list -s ""
copya -list -s "----------------------------------------"
copya -list -s ""
%gnam%.exe %2 %3 %4 %5 %6 %7 %8 %9
if errorlevel 1 goto error
del %gnam%.exe
goto :eof

rem   An error occurred somewhere along the way.  Delete all the
rem   possible temporary files and exit with error status.
rem
:error
if exist %gnam%.c del %gnam%.c
if exist %gnam%.obj del %gnam%.obj
if exist %gnam%.exe del %gnam%.exe
exit /B 3
