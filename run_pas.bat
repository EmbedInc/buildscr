@echo off
rem
rem   RUN_PAS <sourcefile> [arg1 ... arg8]
rem
rem   Compile the Pascal source file, link it with the standard libraries to
rem   create an executable program, run the program, then delete the executable
rem   file.  This essentially "runs" a Pascal source file, and leaves no
rem   intermediate files.  The SOURCEFILE argument is the Pascal source file
rem   name without the .PAS suffix.
rem
rem   Intermediate files will be created (and deleted) in the current directory,
rem   whether the source file is in that directory or not.  This means a Pascal
rem   source file from a remote location can be run, but any temporary files
rem   will be local.
rem
rem   The optional arguments ARG1 - ARG8 are passed to the program when it is
rem   run.
rem
setlocal
call treename_var "%~1.pas" tnam
if not exist "%tnam%" (
  echo No such file: %tnam%
  goto error
  )
for /f "delims=" %%a in ('leafname "%tnam%" .pas') do set gnam=%%a

rem   TNAM is the complete pathname of the original source file, and
rem   GNAM is the generic leafname.

call build_pas "%~1"
if errorlevel 1 goto :error

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
if exist %gnam%.exe del %gnam%.exe
exit /B 3
