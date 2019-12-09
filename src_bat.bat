@echo off
rem
rem   SRC_BAT <batfile gnam>
rem
rem   Build the BAT script by installing it into the appropriate directory.
rem
setlocal
call src_get "%srcdir%" "%~1.bat"
call treename_var (cog)bat tnam
if not exist "%tnam%" call treename_var (cog)com tnam
if not exist "%tnam%" mkdir "%tnam%"
echo %~1.bat
copya -in "%~1.bat" -out "%tnam%/%~1.bat"
del "%~1.bat"
