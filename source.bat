@echo off
rem
rem   SOURCE path
rem
rem   Go to (cog)source/<path>
rem
rem   All debug switches are also reset to off.
rem
for /f "delims=" %%a in ('treename "(cog)source/%~1"') do cd /d %%a
if errorlevel 1 exit /b 3
set debug=
l
if exist .git (
  copya -s "" -list
  git status -s -b
  )
