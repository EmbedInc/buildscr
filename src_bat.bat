@echo off
rem
rem   SRC_BAT <batfile gnam>
rem
rem   "Build" the BAT file by installing it into the appropriate directory.
rem
setlocal
call src_get "%srcdir%" "%~1.bat"

call treename_var "(cog)bat" tnam
if exist "%tnam%" goto :havedir
call treename_var "(cog)com" tnam
:havedir
if not exist "%tnam%" mkdir "%tnam%"

copya "%~1.bat" "%tnam%/%~1.bat"
del "%~1.bat"
