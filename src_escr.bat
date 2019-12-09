@echo off
rem
rem   SRC_ESCR <escr file name>
rem
rem   Build the ESCR script by installing it into the appropriate directory.
rem
setlocal
call src_get "%srcdir%" "%~1.escr"
call treename_var (cog)bat tnam
if not exist "%tnam%" call treename_var (cog)com tnam
if not exist "%tnam%" mkdir "%tnam%"
echo %~1.escr
copya -in "%~1.escr" -out "%tnam%/%~1.escr"
del "%~1.escr"
