@echo off
rem
rem   SOURCE path
rem
rem   Go to (cog)source/<path>
rem
rem   The DEBUG environment variable is initialized to the DEBUGMASTER
rem   environment variable, if it exists.  Otherwise DEBUG is deleted.
rem
for /f "delims=" %%a in ('treename "(cog)source/%~1"') do cd /d %%a
if errorlevel 1 exit /b 3
set debug=%debugmaster%
l

setlocal
set gitrepo=false
if exist .git set gitrepo=true
if exist ..\.git set gitrepo=true
if exist ..\..\.git set gitrepo=true
if %gitrepo%==true (
  copya -s "" -list
  git status -s -b
  )
